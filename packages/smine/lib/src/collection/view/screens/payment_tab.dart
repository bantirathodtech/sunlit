import 'dart:developer' as dev;

import 'package:common/common_widgets.dart';

import '../../../core/util/form_fields.dart';
import '../../widgets/payment_methods_table.dart';

// import 'collection_viewmodel.dart';

class PaymentTab extends StatefulWidget {
  const PaymentTab({Key? key}) : super(key: key);

  @override
  _PaymentTabState createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  final _formKey = GlobalKey<FormState>();
  late CollectionViewModel _viewModel;
  bool _isInitialized = false;

  // Add this line to define the key for PaymentMethodsTable
  final GlobalKey<PaymentMethodsTableState> _paymentTableKey =
      GlobalKey<PaymentMethodsTableState>();

  final TextEditingController _bucketAmountController = TextEditingController();
  final TextEditingController _loadingChargesController =
      TextEditingController();
  final TextEditingController _tonnageAmountController =
      TextEditingController();
  final TextEditingController _companyAmountController =
      TextEditingController();
  final TextEditingController _totalCollectionController =
      TextEditingController();
  final TextEditingController _suspenseAmountController =
      TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  String? _selectedBuckets;
  String? _selectedCreditorName;

  List<Payment> _paymentMethods = [];
  final Map<int, TextEditingController> _amountControllers = {};
  final Map<int, TextEditingController> _remarksControllers = {};

  bool _isQRScanned = false;

  final List<String> buckets = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  final Map<String, String> typeOptionsMap = {
    'Bucket Amount': 'BA',
    'Tonnage Amount': 'TA',
    'Loading Charges': 'LC',
  };

  @override
  void initState() {
    super.initState();
    _isQRScanned = false;

    if (_paymentMethods.isEmpty) {
      _paymentMethods = [
        Payment(
          paymentMethod: '',
          type: '',
          amount: null,
          remarks: '',
          cs_bunit_id:
              '', // You might need to set this to a default value or get it from somewhere
        )
      ];
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        _isInitialized = true;
        _viewModel = Provider.of<CollectionViewModel>(context, listen: false);
        _viewModel.addListener(() {
          // print('PaymentTab: ViewModel notified listeners');
          _updateQRScanState();
        });
        String bunitId = _viewModel.getUserBunitId();
        print('PaymentTab: Initializing with bunitId: $bunitId');
        await _viewModel.fetchBucketRate(bunitId);
        print('PaymentTab: Bucket rate fetched');
        // if (mounted) {
        //   setState(() {
        //     print('PaymentTab: Triggering rebuild after fetching bucket rate');
        //   });
        // }
      }
    });
  }

  void _updateQRScanState() {
    // final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
    if (mounted) {
      setState(() {
        _isQRScanned = _viewModel.isQRScanned;
      });
    }
  }

  void _updateUIWithFetchedData(CollectionFormModel fetchedData) {
    print('PaymentTab: Updating UI with fetched data');
    setState(() {
      // if (fetchedData.dateordered != null) {
      //   // Parse the GraphQL format to UI format
      //   _viewModel
      //       .updateTransactionDate(DateTime.parse(fetchedData.dateordered!));
      // }

      // _selectedBuckets = fetchedData.buckets?.toString();
      // _selectedBuckets = fetchedData.buckets?.toString() ?? '0';
      _selectedBuckets = fetchedData.buckets != null && fetchedData.buckets! > 0
          ? fetchedData.buckets.toString()
          : null;
      print('PaymentTab: Fetched buckets: $_selectedBuckets');
      _bucketAmountController.text = fetchedData.bucketAmount?.toString() ?? '';
      _loadingChargesController.text =
          fetchedData.loadingCharges?.toString() ?? '';
      _tonnageAmountController.text =
          fetchedData.tonnageAmount?.toString() ?? '';
      _companyAmountController.text =
          fetchedData.companyAmount?.toString() ?? '';
      _totalCollectionController.text =
          fetchedData.grosstotal?.toString() ?? '';
      _selectedCreditorName = fetchedData.b2ccustomername;
      _suspenseAmountController.text = fetchedData.suspense?.toString() ?? '';
      _commentsController.text = fetchedData.description ?? '';

      print(
          'PaymentTab: Updated bucketAmount: ${_bucketAmountController.text}');
      print(
          'PaymentTab: Updated loadingCharges: ${_loadingChargesController.text}');
      print(
          'PaymentTab: Updated tonnageAmount: ${_tonnageAmountController.text}');
      print(
          'PaymentTab: Updated totalCollection: ${_totalCollectionController.text}');

      print('PaymentTab: Fetched payment methods: ${fetchedData.payments}');
      _paymentMethods = fetchedData.payments?.map((payment) {
            print('PaymentTab: Processing payment: $payment');
            return Payment(
              paymentMethod: payment.paymentMethod,
              type: payment.type,
              amount: payment.amount,
              remarks: payment.remarks,
              cs_bunit_id: payment.cs_bunit_id ??
                  Provider.of<CollectionViewModel>(context, listen: false)
                      .getUserBunitId(),
            );
          }).toList() ??
          [
            Payment(
              paymentMethod: '',
              type: '',
              amount: null,
              remarks: '',
              cs_bunit_id:
                  Provider.of<CollectionViewModel>(context, listen: false)
                      .getUserBunitId(),
            )
          ];
      print('PaymentTab: Updated _paymentMethods: $_paymentMethods');

      _clearPaymentMethodControllers();
      for (var i = 0; i < _paymentMethods.length; i++) {
        _amountControllers[i] = TextEditingController(
            text: _paymentMethods[i].amount?.toString() ?? '');
        _remarksControllers[i] =
            TextEditingController(text: _paymentMethods[i].remarks ?? '');
      }
    });

    // Trigger calculation after updating the fields
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CollectionViewModel>(context, listen: false)
          .calculateTotalCollection();
    });

    // _viewModel.updateBucketAmount(_selectedBuckets);
    if (_selectedBuckets != null) {
      _viewModel.updateBucketAmount(_selectedBuckets!);
    } else {
      _bucketAmountController.text = '';
    }
    _bucketAmountController.text =
        _viewModel.collectionFormData.bucketAmount?.toStringAsFixed(2) ??
            '0.00';
    print(
        'PaymentTab: Updated bucket amount after fetch: ${_bucketAmountController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionViewModel>(
      builder: (context, viewModel, child) {
        // print('PaymentTab: Rebuilding with bucketAmount: ${viewModel.collectionFormData.bucketAmount}');
        // print('PaymentTab: Rebuilding with gross total: ${viewModel.collectionFormData.grosstotal}');
        // Update the Total Collection field
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _totalCollectionController.text =
              viewModel.collectionFormData.grosstotal?.toStringAsFixed(2) ?? '';
        });
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildQRScanner(viewModel),
                const SizedBox(height: 16.0),
                _buildFormFields(viewModel),
                const SizedBox(height: 16.0),
                _buildPaymentMethodsCard(viewModel),
                const SizedBox(height: 16.0),
                _buildSubmitButton(viewModel),

                //   // _buildQRScanner(viewModel),
                //   // const SizedBox(height: 8.0),
                //   // CommonWidgets.buildBucketDropdown(
                //   //   items: buckets,
                //   //   selectedValue: _selectedBuckets,
                //   //   hint: 'Buckets',
                //   //   onChanged: (value) {
                //   //     print('PaymentTab: Bucket dropdown changed to: $value');
                //   //     if (value != null) {
                //   //       _viewModel.updateBucketAmount(value);
                //   //       setState(() {
                //   //         _selectedBuckets = value;
                //   //         _bucketAmountController.text = _viewModel
                //   //                 .collectionFormData.bucketAmount
                //   //                 ?.toStringAsFixed(2) ??
                //   //             '';
                //   //         print(
                //   //             'PaymentTab: Updated bucket amount: ${_bucketAmountController.text}');
                //   //       });
                //   //     } else {
                //   //       setState(() {
                //   //         _selectedBuckets = null;
                //   //         _bucketAmountController.text = '';
                //   //         print('PaymentTab: Cleared bucket amount');
                //   //       });
                //   //     }
                //   //   },
                //   //   fieldName: 'buckets',
                //   // ),
                //   FormFields.buildDropdownField(
                //     fieldName: 'Buckets',
                //     value: _selectedBuckets,
                //     options: buckets,
                //     onChanged: (value) {
                //       print('PaymentTab: Bucket dropdown changed to: $value');
                //       if (value != null) {
                //         _viewModel.updateBucketAmount(value);
                //         setState(() {
                //           _selectedBuckets = value;
                //           _bucketAmountController.text = _viewModel
                //                   .collectionFormData.bucketAmount
                //                   ?.toStringAsFixed(2) ??
                //               '';
                //           print(
                //               'PaymentTab: Updated bucket amount: ${_bucketAmountController.text}');
                //         });
                //       } else {
                //         setState(() {
                //           _selectedBuckets = null;
                //           _bucketAmountController.text = '';
                //           print('PaymentTab: Cleared bucket amount');
                //         });
                //       }
                //     },
                //   ),
                //   const SizedBox(height: 8.0),
                //   // CommonWidgets.buildTextField(
                //   //   controller: _bucketAmountController,
                //   //   labelText: 'Bucket Amount',
                //   //   keyboardType: TextInputType.phone,
                //   //   // readOnly: true, // Make it read-only as it's calculated
                //   //   onChanged: (value) {
                //   //     print('PaymentTab: Bucket Amount changed to $value');
                //   //     viewModel.updateFormField(
                //   //         'bucketAmount', double.tryParse(value) ?? 0);
                //   //   },
                //   // ),
                //   FormFields.buildTextCollectionField(
                //     fieldName: 'Bucket Amount',
                //     controller: _bucketAmountController,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //     readOnly: true, // Make it read-only as it's calculated
                //     hintText: 'Select bucket for bucket amount',
                //     onChanged: (value) {
                //       print('PaymentTab: Bucket Amount changed to $value');
                //       viewModel.updateFormField(
                //           'bucketAmount', double.tryParse(value) ?? 0);
                //     },
                //     onTap: () {
                //       if (_bucketAmountController.text.isEmpty) {
                //         setState(() {
                //           _bucketAmountController.text = 'Select bucket';
                //         });
                //       }
                //     },
                //     // hintText: 'Select bucket for bucket amount',
                //   ),
                //   const SizedBox(height: 8.0),
                //   // CommonWidgets.buildTextField(
                //   //   controller: _loadingChargesController,
                //   //   labelText: 'Loading Charges',
                //   //   keyboardType: TextInputType.number,
                //   //   onChanged: (value) {
                //   //     print('PaymentTab: Loading Charges changed to $value');
                //   //     viewModel.updateFormField(
                //   //         'loadingCharges', double.tryParse(value) ?? 0);
                //   //   },
                //   // ),
                //   FormFields.buildTextCollectionField(
                //     fieldName: 'Loading Charges',
                //     controller: _loadingChargesController,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //     onChanged: (value) {
                //       print('PaymentTab: Loading Charges changed to $value');
                //       viewModel.updateFormField(
                //           'loadingCharges', double.tryParse(value) ?? 0);
                //     },
                //   ),
                //   const SizedBox(height: 8.0),
                //   // CommonWidgets.buildTextField(
                //   //   controller: _tonnageAmountController,
                //   //   labelText: 'Tonnage Amount',
                //   //   keyboardType: TextInputType.number,
                //   //   onChanged: (value) {
                //   //     print('PaymentTab: Tonnage Amount changed to $value');
                //   //     viewModel.updateFormField(
                //   //         'tonnageAmount', double.tryParse(value) ?? 0);
                //   //   },
                //   // ),
                //   FormFields.buildTextCollectionField(
                //     fieldName: 'Tonnage Amount',
                //     controller: _tonnageAmountController,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //     onChanged: (value) {
                //       print('PaymentTab: Tonnage Amount changed to $value');
                //       viewModel.updateFormField(
                //           'tonnageAmount', double.tryParse(value) ?? 0);
                //     },
                //   ),
                //   const SizedBox(height: 8.0),
                //   // CommonWidgets.buildTextField(
                //   //   controller: _companyAmountController,
                //   //   labelText: 'Company Amount',
                //   //   keyboardType: TextInputType.number,
                //   // ),
                //   FormFields.buildTextCollectionField(
                //     fieldName: 'Company Amount',
                //     controller: _companyAmountController,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [numberDecimalInputFormatter],
                //   ),
                //
                //   const SizedBox(height: 8.0),
                //   // CommonWidgets.buildDropdown(
                //   //   items: viewModel.dropdownOptions['creditorName'] ?? [],
                //   //   selectedValue: _selectedCreditorName,
                //   //   hint: 'Creditor Name',
                //   //   onChanged: (value) =>
                //   //       setState(() => _selectedCreditorName = value),
                //   //   fieldName: 'creditorName',
                //   // ),
                //   FormFields.buildDropdownField(
                //     fieldName: 'Creditor Name',
                //     value: _selectedCreditorName,
                //     options: viewModel.dropdownOptions['creditorName'] ?? [],
                //     onChanged: (value) =>
                //         setState(() => _selectedCreditorName = value),
                //   ),
                //   const SizedBox(height: 8.0),
                //   // CommonWidgets.buildTextField(
                //   //   controller: _suspenseAmountController,
                //   //   labelText: 'Suspense Amount',
                //   //   keyboardType: TextInputType.number,
                //   // ),
                //   // FormFields.buildTextCollectionField(
                //   //   fieldName: 'Suspense Amount',
                //   //   controller: _suspenseAmountController,
                //   //   keyboardType:
                //   //       const TextInputType.numberWithOptions(decimal: true),
                //   //   inputFormatters: [numberDecimalInputFormatter],
                //   //   // keyboardType: TextInputType.number,
                //   // ),
                //   // const SizedBox(height: 8.0),
                //   // CommonWidgets.buildTextField(
                //   //   controller: _commentsController,
                //   //   labelText: 'Comments',
                //   //   maxLines: 3,
                //   // ),
                //   FormFields.buildTextCollectionField(
                //     fieldName: 'Comments',
                //     controller: _commentsController,
                //     keyboardType: TextInputType.text,
                //     maxLines: 3,
                //   ),
                //   const SizedBox(height: 8.0),
                //   // CommonWidgets.buildTextField(
                //   //   controller: _totalCollectionController,
                //   //   labelText: 'Total Collection',
                //   //   keyboardType: TextInputType.number,
                //   // ),
                //   FormFields.buildTextCollectionField(
                //     fieldName: 'Total Collection',
                //     controller: _totalCollectionController,
                //     keyboardType: TextInputType.number,
                //     readOnly: true, // Make it read-only as it's calculated'
                //   ),
                //   const SizedBox(height: 8.0),
                //   // _buildPaymentMethodsTable(viewModel),
                //   // PaymentMethodsTable(
                //   //   paymentMethods: _paymentMethods,
                //   //   onPaymentMethodsChanged: (updatedPaymentMethods) {
                //   //     setState(() {
                //   //       _paymentMethods = updatedPaymentMethods;
                //   //     });
                //   //   },
                //   //   totalCollection: viewModel.collectionFormData.grosstotal ?? 0,
                //   // ),
                //   // Update the PaymentMethodsTable to include the key
                //   PaymentMethodsTable(
                //     key: _paymentTableKey,
                //     paymentMethods: _paymentMethods,
                //     onPaymentMethodsChanged: (updatedPaymentMethods) {
                //       setState(() {
                //         _paymentMethods = updatedPaymentMethods;
                //       });
                //     },
                //     totalCollection: viewModel.collectionFormData.grosstotal ?? 0,
                //   ),
                //   const SizedBox(height: 8.0),
                //   // ElevatedButton(
                //   //   onPressed: () => _submitForm(viewModel),
                //   //   child: const Text('Submit'),
                //   // ),
                //   CustomButtons.primaryButton(
                //     label: 'Submit',
                //     onPressed: () => _submitForm(viewModel),
                //     color: Colors.green,
                //     width: 150, // Specify a custom width
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 10.0, horizontal: 20.0),
                //     textStyle: const TextStyle(
                //       fontSize: 16.0,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //     ),
                //   ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQRScanner(CollectionViewModel viewModel) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Scan QR Code',
            //   style: Theme.of(context).textTheme.headlineSmall,
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 16),
            QRScannerWidget(
              scanType: 'Entry',
              currentTab: 'Payment',
              onScan: (String sOrderId) async {
                print('PaymentTab: QR scanned with sOrderId: $sOrderId');
                await viewModel.fetchDataFromQR(sOrderId);
                _updateUIWithFetchedData(viewModel.collectionFormData);
              },
            ),
            // const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isQRScanned ? Icons.check_circle : Icons.info_outline,
                  // size: 26,
                  color: _isQRScanned ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _isQRScanned
                      ? 'QR Code Scanned'
                      : 'Please scan a QR code to proceed',
                  style: TextStyle(
                    color: _isQRScanned ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(CollectionViewModel viewModel) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormFields.buildDropdownField(
              fieldName: 'Buckets',
              value: _selectedBuckets,
              options: buckets,
              onChanged: _isQRScanned
                  ? (value) {
                      print('PaymentTab: Bucket dropdown changed to: $value');
                      if (value != null) {
                        _viewModel.updateBucketAmount(value);
                        setState(() {
                          _selectedBuckets = value;
                          _bucketAmountController.text = _viewModel
                                  .collectionFormData.bucketAmount
                                  ?.toStringAsFixed(2) ??
                              '';
                          print(
                              'PaymentTab: Updated bucket amount: ${_bucketAmountController.text}');
                        });
                      } else {
                        setState(() {
                          _selectedBuckets = null;
                          _bucketAmountController.text = '';
                          print('PaymentTab: Cleared bucket amount');
                        });
                      }
                    }
                  : null,
            ),
            const SizedBox(height: 8.0),
            FormFields.buildTextCollectionField(
              fieldName: 'Bucket Amount',
              controller: _bucketAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              readOnly: true,
              hintText: 'Select bucket for bucket amount',
              onChanged: _isQRScanned
                  ? (value) {
                      print('PaymentTab: Bucket Amount changed to $value');
                      viewModel.updateFormField(
                          'bucketAmount', double.tryParse(value) ?? 0);
                    }
                  : null,
            ),
            const SizedBox(height: 8.0),
            FormFields.buildTextCollectionField(
              fieldName: 'Loading Charges',
              controller: _loadingChargesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: _isQRScanned
                  ? (value) {
                      print('PaymentTab: Loading Charges changed to $value');
                      viewModel.updateFormField(
                          'loadingCharges', double.tryParse(value) ?? 0);
                    }
                  : null,
            ),
            const SizedBox(height: 8.0),
            FormFields.buildTextCollectionField(
              fieldName: 'Tonnage Amount',
              controller: _tonnageAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: _isQRScanned
                  ? (value) {
                      print('PaymentTab: Tonnage Amount changed to $value');
                      viewModel.updateFormField(
                          'tonnageAmount', double.tryParse(value) ?? 0);
                    }
                  : null,
            ),
            const SizedBox(height: 8.0),
            FormFields.buildTextCollectionField(
              fieldName: 'Company Amount',
              controller: _companyAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [numberDecimalInputFormatter],
              onChanged: _isQRScanned ? null : null,
            ),
            const SizedBox(height: 8.0),
            FormFields.buildDropdownField(
              fieldName: 'Creditor Name',
              value: _selectedCreditorName,
              options: viewModel.dropdownOptions['creditorName'] ?? [],
              onChanged: _isQRScanned
                  ? (value) => setState(() => _selectedCreditorName = value)
                  : null,
            ),
            const SizedBox(height: 8.0),
            FormFields.buildTextCollectionField(
              fieldName: 'Comments',
              controller: _commentsController,
              keyboardType: TextInputType.text,
              maxLines: 3,
              onChanged: _isQRScanned ? null : null,
            ),
            const SizedBox(height: 8.0),
            FormFields.buildTextCollectionField(
              fieldName: 'Total Collection',
              controller: _totalCollectionController,
              keyboardType: TextInputType.number,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsCard(CollectionViewModel viewModel) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   'Payment Methods',
            //   style: Theme.of(context).textTheme.headlineMedium,
            //   textAlign: TextAlign.center,
            // ),
            // const SizedBox(height: 16),
            PaymentMethodsTable(
              key: _paymentTableKey,
              paymentMethods: _paymentMethods,
              onPaymentMethodsChanged: (updatedPaymentMethods) {
                if (_isQRScanned) {
                  setState(() {
                    _paymentMethods = updatedPaymentMethods;
                  });
                }
              },
              totalCollection: viewModel.collectionFormData.grosstotal ?? 0,
              isEnabled: _isQRScanned,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(CollectionViewModel viewModel) {
    return CustomButtons.primaryButton(
      label: 'Submit',
      onPressed: () {
        if (_isQRScanned) {
          _submitForm(viewModel);
        }
      },
      color: Colors.green,
      width: 150, // Specify a custom width
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      textStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
  // Widget _buildQRScanner(CollectionViewModel viewModel) {
  //   return Row(
  //     children: [
  //       if (_isQRScanned)
  //         const Padding(
  //           padding: EdgeInsets.only(right: 8.0),
  //           child: Icon(Icons.check_circle, color: Colors.green, size: 24),
  //         ),
  //       Expanded(
  //         child: QRScannerWidget(
  //           scanType: 'Entry',
  //           currentTab: 'Payment',
  //           onScan: (String sOrderId) async {
  //             print('PaymentTab: QR scanned with sOrderId: $sOrderId');
  //             await viewModel.fetchDataFromQR(sOrderId);
  //             print(
  //                 'PaymentTab: fetchDataFromQR completed for sOrderId: $sOrderId');
  //             _updateUIWithFetchedData(viewModel.collectionFormData);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildPaymentMethodsTable(CollectionViewModel viewModel) {
  //   return PaymentMethodsTable(
  //     paymentMethods: _paymentMethods,
  //     onPaymentMethodsChanged: (updatedPaymentMethods) {
  //       setState(() {
  //         _paymentMethods = updatedPaymentMethods;
  //       });
  //     },
  //     // totalCollection: viewModel.collectionFormData.grosstotal ?? 0,
  //   );
  // }

  // // ... [All other widget building methods remain the same]
  // Widget _buildPaymentMethodsTable(CollectionViewModel viewModel) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Text(
  //         'Payment Methods',
  //         style: Theme.of(context).textTheme.titleMedium,
  //       ),
  //       const SizedBox(height: 8.0),
  //       Table(
  //         border: TableBorder.all(color: Colors.grey[300]!),
  //         columnWidths: const {
  //           0: FlexColumnWidth(2),
  //           1: FlexColumnWidth(3),
  //           2: FlexColumnWidth(2),
  //           3: FlexColumnWidth(2),
  //           4: FlexColumnWidth(1),
  //         },
  //         children: [
  //           TableRow(
  //             children: [
  //               _buildTableHeader('Method'),
  //               _buildTableHeader('Type'),
  //               _buildTableHeader('Amount'),
  //               _buildTableHeader('Remarks'),
  //               _buildTableHeader(''),
  //             ],
  //           ),
  //           ..._paymentMethods.asMap().entries.map((entry) {
  //             final index = entry.key;
  //             return TableRow(
  //               children: [
  //                 _buildPaymentMethodDropdown(viewModel, index),
  //                 _buildTypeDropdown(index),
  //                 _buildAmountField(index),
  //                 _buildRemarksField(index),
  //                 _buildDeleteButton(index),
  //               ],
  //             );
  //           }).toList(),
  //         ],
  //       ),
  //       const SizedBox(height: 8.0),
  //       ElevatedButton(
  //         onPressed: _addPaymentMethod,
  //         child: const Text('Add Entries', style: TextStyle(fontSize: 12)),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildTableHeader(String text) {
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: Text(
  //       text,
  //       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }
  //
  // Widget _buildPaymentMethodDropdown(CollectionViewModel viewModel, int index) {
  //   return Padding(
  //     padding: const EdgeInsets.all(2.0),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         isExpanded: true,
  //         value: _paymentMethods[index].paymentMethod?.isNotEmpty == true
  //             ? _paymentMethods[index].paymentMethod
  //             : null,
  //         hint: const Text('Select', style: TextStyle(fontSize: 12)),
  //         items:
  //             viewModel.dropdownOptions['paymentMethod']?.map((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(value,
  //                         style: const TextStyle(fontSize: 12),
  //                         overflow: TextOverflow.ellipsis),
  //                   );
  //                 }).toList() ??
  //                 [],
  //         onChanged: (value) {
  //           setState(() {
  //             _paymentMethods[index] = Payment(
  //               paymentMethod: value ?? '',
  //               type: _paymentMethods[index].type,
  //               amount: _paymentMethods[index].amount,
  //               remarks: _paymentMethods[index].remarks,
  //             );
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildTypeDropdown(int index) {
  //   final typeOptions = typeOptionsMap.keys.toList();
  //   return Padding(
  //     padding: const EdgeInsets.all(2.0),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         isExpanded: true,
  //         value: _paymentMethods[index].type?.isNotEmpty == true
  //             ? typeOptionsMap.entries
  //                 .firstWhere(
  //                     (entry) => entry.value == _paymentMethods[index].type,
  //                     orElse: () => const MapEntry('', ''))
  //                 .key
  //             : null,
  //         hint: const Text('Select', style: TextStyle(fontSize: 12)),
  //         items: typeOptions.map((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(value,
  //                 style: const TextStyle(fontSize: 12),
  //                 overflow: TextOverflow.ellipsis),
  //           );
  //         }).toList(),
  //         onChanged: (value) {
  //           setState(() {
  //             _paymentMethods[index] = Payment(
  //               paymentMethod: _paymentMethods[index].paymentMethod,
  //               type: typeOptionsMap[value] ?? '',
  //               amount: _paymentMethods[index].amount,
  //               remarks: _paymentMethods[index].remarks,
  //             );
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildAmountField(int index) {
  //   return Padding(
  //     padding: const EdgeInsets.all(2.0),
  //     child: TextFormField(
  //       controller: _amountControllers[index],
  //       keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //       style: const TextStyle(fontSize: 12),
  //       decoration: const InputDecoration(
  //         isDense: true,
  //         contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
  //       ),
  //       onChanged: (value) {
  //         setState(() {
  //           _paymentMethods[index] = Payment(
  //             paymentMethod: _paymentMethods[index].paymentMethod,
  //             type: _paymentMethods[index].type,
  //             amount: double.tryParse(value),
  //             remarks: _paymentMethods[index].remarks,
  //           );
  //         });
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _buildRemarksField(int index) {
  //   return Padding(
  //     padding: const EdgeInsets.all(2.0),
  //     child: TextFormField(
  //       controller: _remarksControllers[index],
  //       style: const TextStyle(fontSize: 12),
  //       decoration: const InputDecoration(
  //         isDense: true,
  //         contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
  //       ),
  //       onChanged: (value) {
  //         setState(() {
  //           _paymentMethods[index] = Payment(
  //             paymentMethod: _paymentMethods[index].paymentMethod,
  //             type: _paymentMethods[index].type,
  //             amount: _paymentMethods[index].amount,
  //             remarks: value,
  //           );
  //         });
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _buildDeleteButton(int index) {
  //   return IconButton(
  //     icon: const Icon(Icons.delete, color: Colors.red, size: 16),
  //     onPressed: () => _deletePaymentMethod(index),
  //     padding: EdgeInsets.zero,
  //     constraints: const BoxConstraints(),
  //   );
  // }
  //
  // void _addPaymentMethod() {
  //   final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
  //   setState(() {
  //     _paymentMethods.add(Payment(
  //       paymentMethod: '',
  //       type: '',
  //       amount: null,
  //       remarks: '',
  //       cs_bunit_id: viewModel.getUserBunitId(),
  //     ));
  //     _clearPaymentMethodControllers();
  //   });
  // }
  //
  // void _deletePaymentMethod(int index) {
  //   setState(() {
  //     _paymentMethods.removeAt(index);
  //     _clearPaymentMethodControllers();
  //   });
  // }
  //
  // void _clearPaymentMethodControllers() {
  //   _amountControllers.clear();
  //   _remarksControllers.clear();
  //   for (var i = 0; i < _paymentMethods.length; i++) {
  //     _amountControllers[i] = TextEditingController(
  //         text: _paymentMethods[i].amount?.toString() ?? '');
  //     _remarksControllers[i] =
  //         TextEditingController(text: _paymentMethods[i].remarks ?? '');
  //   }
  // }

  void _submitForm(CollectionViewModel viewModel) async {
    dev.log('Step 1: Submitting form', name: 'PaymentTab');
    print('PaymentTab: Submitting form');
    dev.log('Current payment methods: $_paymentMethods', name: 'PaymentTab');

    if (_formKey.currentState!.validate()) {
      // Validate the form data
      if (viewModel.collectionFormData.sOrderId == null ||
          viewModel.collectionFormData.sOrderId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please scan a valid QR code first')),
        );
        return;
      }
      dev.log(
          'Step 2: Submitting form for sOrderId: ${viewModel.collectionFormData.sOrderId}',
          name: 'PaymentTab');

      print(
          'Submitting form for sOrderId: ${viewModel.collectionFormData.sOrderId}');

      // Update all form fields in the viewModel
      print('PaymentTab: Updating ViewModel with form data');
      dev.log('Step 3: Updating ViewModel with form data', name: 'PaymentTab');
      _updateViewModelWithFormData(viewModel);
      // viewModel.collectionFormData.buckets =
      //     _selectedBuckets != null ? int.tryParse(_selectedBuckets!) : null;
      // viewModel.collectionFormData.bucketAmount =
      //     double.tryParse(_bucketAmountController.text);
      // viewModel.collectionFormData.loadingCharges =
      //     double.tryParse(_loadingChargesController.text);
      // viewModel.collectionFormData.tonnageAmount =
      //     double.tryParse(_tonnageAmountController.text);
      // viewModel.collectionFormData.companyAmount =
      //     double.tryParse(_companyAmountController.text);
      // viewModel.collectionFormData.grosstotal =
      //     double.tryParse(_totalCollectionController.text);
      // viewModel.collectionFormData.b2ccustomername = _selectedCreditorName;
      // viewModel.collectionFormData.suspense =
      //     double.tryParse(_suspenseAmountController.text);
      // viewModel.collectionFormData.payments = _paymentMethods;
      // viewModel.collectionFormData.description = _commentsController.text;

      // viewModel.updateFormField('buckets', _selectedBuckets);
      // viewModel.updateFormField('bucketAmount', _bucketAmountController.text);
      // viewModel.updateFormField(
      //     'loadingCharges', _loadingChargesController.text);
      // viewModel.updateFormField('tonnageAmount', _tonnageAmountController.text);
      // viewModel.updateFormField('companyAmount', _companyAmountController.text);
      // viewModel.updateFormField('grosstotal', _totalCollectionController.text);
      // viewModel.updateFormField('b2ccustomername', _selectedCreditorName);
      // viewModel.updateFormField('suspense', _suspenseAmountController.text);
      // viewModel.updateFormField('description', _commentsController.text);
      // // viewModel.collectionFormData.payments = _paymentMethods;
      // viewModel.payments = _paymentMethods;
      ///above one is old
      ///below one is new
//       // Update the fields with proper type conversion
//       viewModel.updateFormField(
//           'buckets', int.tryParse(_selectedBuckets ?? ''));
//       viewModel.updateFormField(
//           'bucketAmount', double.tryParse(_bucketAmountController.text));
//       viewModel.updateFormField(
//           'loadingCharges', double.tryParse(_loadingChargesController.text));
//       viewModel.updateFormField(
//           'tonnageAmount', double.tryParse(_tonnageAmountController.text));
//       viewModel.updateFormField(
//           'companyAmount', double.tryParse(_companyAmountController.text));
//       viewModel.updateFormField(
//           'grosstotal', double.tryParse(_totalCollectionController.text));
//       viewModel.updateFormField('b2ccustomername', _selectedCreditorName);
//       viewModel.updateFormField(
//           'suspense', double.tryParse(_suspenseAmountController.text));
//       viewModel.updateFormField('description', _commentsController.text);
//       // viewModel.payments = _paymentMethods;
//       // Update the viewModel with the latest payment data
//       viewModel.payments = _paymentMethods
//           .where((payment) =>
//               payment.paymentMethod != null &&
//               payment.paymentMethod!.isNotEmpty &&
//               payment.amount != null &&
//               payment.amount! > 0)
//           .toList();

      // Check if payment entries sum matches Total Collection
      print(
          'PaymentTab: Current payment methods before submission: $_paymentMethods');
      dev.log(
          'Step 4: Current payment methods before submission: $_paymentMethods',
          name: 'PaymentTab');
      double paymentSum = _paymentMethods.fold(
          0, (sum, payment) => sum + (payment.amount ?? 0));
      dev.log('Step 5: Total payment sum: $paymentSum', name: 'PaymentTab');
      dev.log(
          'Step 6: Expected total (grosstotal): ${viewModel.collectionFormData.grosstotal}',
          name: 'PaymentTab');
      print('PaymentTab: Total payment sum: $paymentSum');
      print(
          'PaymentTab: Expected total (grosstotal): ${viewModel.collectionFormData.grosstotal}');

      if ((paymentSum - viewModel.collectionFormData.grosstotal!).abs() >=
          0.01) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Total of payment entries must match the Total Collection')),
        );
        return;
      }

      viewModel.setUpsertingFromPaymentScreen(true);
      dev.log('Step 7: Set isUpsertingFromPaymentScreen to true',
          name: 'PaymentTab');

      try {
        print('PaymentTab: Setting payments in CollectionFormModel');
        dev.log('Step 8: Setting payments in CollectionFormModel',
            name: 'PaymentTab');

        // Ensure payment entries are included in the form data
        viewModel.collectionFormData.payments = _paymentMethods;
        print(
            'PaymentTab: Payments set in CollectionFormModel: ${viewModel.collectionFormData.payments}');
        dev.log(
            'Step 9: Payments set in CollectionFormModel: ${viewModel.collectionFormData.payments}',
            name: 'PaymentTab');

        bool result = await viewModel.upsertCollectionFormData();
        if (result) {
          dev.log('Step 10: Upsert successful', name: 'PaymentTab');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Payment data submitted successfully')),
          );
          _clearForm();
          viewModel.resetForm();
          // Reset the payment methods table
          // setState(() {
          //   _paymentMethods = [
          //     Payment(
          //       paymentMethod: '',
          //       type: '',
          //       amount: null,
          //       remarks: '',
          //       cs_bunit_id: viewModel.getUserBunitId(),
          //     )
          //   ];
          // });
          // Reset the payment methods table
          _paymentTableKey.currentState?.resetTable();
        } else {
          dev.log('Step 10: Upsert failed', name: 'PaymentTab');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Error submitting form: ${viewModel.errorMessage}')),
          );
        }
      } catch (e, stackTrace) {
        dev.log('Step 10: Error submitting form: $e', name: 'PaymentTab');

        print('Error submitting form: $e');
        print('Stack trace: $stackTrace');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting form: $e')),
        );
      }
    }
  }

  void _updateViewModelWithFormData(CollectionViewModel viewModel) {
    print('PaymentTab: Updating ViewModel with form data');

    viewModel.updateFormField('buckets', int.tryParse(_selectedBuckets ?? ''));
    viewModel.updateFormField(
        'bucketAmount', double.tryParse(_bucketAmountController.text));
    viewModel.updateFormField(
        'loadingCharges', double.tryParse(_loadingChargesController.text));
    viewModel.updateFormField(
        'tonnageAmount', double.tryParse(_tonnageAmountController.text));
    viewModel.updateFormField(
        'companyAmount', double.tryParse(_companyAmountController.text));
    viewModel.updateFormField(
        'grosstotal', double.tryParse(_totalCollectionController.text));
    viewModel.updateFormField('b2ccustomername', _selectedCreditorName);
    viewModel.updateFormField(
        'suspense', double.tryParse(_suspenseAmountController.text));
    viewModel.updateFormField('description', _commentsController.text);

    // Update the viewModel with the latest payment data
    print('PaymentTab: Updating payments in ViewModel');
    viewModel.payments = _paymentMethods
        .where((payment) =>
            payment.paymentMethod != null &&
            payment.paymentMethod!.isNotEmpty &&
            payment.amount != null &&
            payment.amount! > 0)
        .toList();
    print('PaymentTab: Updated payments in ViewModel: ${viewModel.payments}');

    // Ensure the payments are also updated in the collectionFormData
    print('PaymentTab: Updating payments in CollectionFormModel');
    viewModel.collectionFormData.payments = viewModel.payments;
    print(
        'PaymentTab: Updated payments in CollectionFormModel: ${viewModel.collectionFormData.payments}');
  }

  void _clearForm() {
    _bucketAmountController.clear();
    _loadingChargesController.clear();
    _tonnageAmountController.clear();
    _companyAmountController.clear();
    _totalCollectionController.clear();
    _suspenseAmountController.clear();
    _commentsController.clear();

    setState(() {
      _selectedCreditorName = null;
      _selectedBuckets = null;
      _paymentMethods = [];
      _clearPaymentMethodControllers();
      _isQRScanned = false;
    });
  }

  void _clearPaymentMethodControllers() {
    _amountControllers.clear();
    _remarksControllers.clear();
  }

  @override
  void dispose() {
    // final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
    // viewModel.removeListener(_updateQRScanState);
    // _viewModel.removeListener(_updateQRScanState);
    if (_isInitialized) {
      _viewModel.removeListener(_updateQRScanState);
    }
    _bucketAmountController.dispose();
    _loadingChargesController.dispose();
    _tonnageAmountController.dispose();
    _companyAmountController.dispose();
    _totalCollectionController.dispose();
    _suspenseAmountController.dispose();
    _commentsController.dispose();
    _amountControllers.values.forEach((controller) => controller.dispose());
    _remarksControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
