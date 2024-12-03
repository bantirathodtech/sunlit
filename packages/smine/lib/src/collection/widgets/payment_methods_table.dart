import 'package:common/common_widgets.dart';

class PaymentMethodsTable extends StatefulWidget {
  final List<Payment> paymentMethods;
  final Function(List<Payment>) onPaymentMethodsChanged;
  final double totalCollection;
  final bool isEnabled; // Add this line

  const PaymentMethodsTable({
    Key? key,
    required this.paymentMethods,
    required this.onPaymentMethodsChanged,
    required this.totalCollection,
    this.isEnabled = true, // Add this line with a default value
  }) : super(key: key);

  @override
  PaymentMethodsTableState createState() => PaymentMethodsTableState();
}

class PaymentMethodsTableState extends State<PaymentMethodsTable> {
  final Map<int, TextEditingController> _amountControllers = {};
  final Map<int, TextEditingController> _remarksControllers = {};
  double _sumOfPayments = 0;
  late List<Payment> _displayedPaymentMethods;

  final Map<String, String> typeOptionsMap = {
    'Bucket Amount': 'BA',
    'Tonnage Amount': 'TA',
    'Loading Charges': 'LC',
  };

  @override
  void initState() {
    super.initState();
    _initDisplayedPaymentMethods();
    _initControllers();
    _calculateSumOfPayments();
  }

  void _initDisplayedPaymentMethods() {
    if (widget.paymentMethods.isEmpty) {
      _displayedPaymentMethods = [
        Payment(
          paymentMethod: '',
          type: '',
          amount: null,
          remarks: '',
          cs_bunit_id: Provider.of<CollectionViewModel>(context, listen: false)
              .getUserBunitId(),
        )
      ];
    } else {
      _displayedPaymentMethods = List.from(widget.paymentMethods);
    }
  }

  // void _initControllers() {
  //   for (var i = 0; i < widget.paymentMethods.length; i++) {
  //     _amountControllers[i] = TextEditingController(
  //         text: widget.paymentMethods[i].amount?.toString() ?? '');
  //     _remarksControllers[i] =
  //         TextEditingController(text: widget.paymentMethods[i].remarks ?? '');
  //   }
  // }

  void _initControllers() {
    for (var i = 0; i < _displayedPaymentMethods.length; i++) {
      _amountControllers[i] = TextEditingController(
          text: _displayedPaymentMethods[i].amount?.toString() ?? '');
      _remarksControllers[i] = TextEditingController(
          text: _displayedPaymentMethods[i].remarks ?? '');
    }
  }

  void _calculateSumOfPayments() {
    // _sumOfPayments = widget.paymentMethods
    _sumOfPayments = _displayedPaymentMethods.fold(
        0, (sum, payment) => sum + (payment.amount ?? 0));
  }

  bool _isPaymentSumValid() {
    return (_sumOfPayments - widget.totalCollection).abs() < 0.01;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CollectionViewModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Payment Methods',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: AppDimensions.smallPadding),
        Table(
          border: TableBorder.all(color: Colors.grey[300]!),
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                _buildTableHeader('Method'),
                _buildTableHeader('Amount'),
                _buildTableHeader('Remarks'),
                _buildTableHeader(''),
              ],
            ),
            ..._displayedPaymentMethods.asMap().entries.map((entry) {
              final index = entry.key;
              return TableRow(
                children: [
                  _buildPaymentMethodDropdown(viewModel, index),
                  _buildAmountField(index),
                  _buildRemarksField(index),
                  _buildDeleteButton(index),
                ],
              );
            }).toList(),
          ],
        ),
        SizedBox(height: AppDimensions.mediumPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   '${widget.totalCollection.toStringAsFixed(2)}',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            Text(
              'Entered: ${_sumOfPayments.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isPaymentSumValid() ? Colors.green : Colors.red,
              ),
            ),
            // ElevatedButton(
            //   onPressed: () => _addPaymentMethod(viewModel),
            //   child: const Text('Add Entries',
            //       style: TextStyle(fontSize: AppDimensions.bodyText)),
            // ),
            CustomButtons.secondaryButton(
              label: 'Add Entries',
              onPressed: () => _addPaymentMethod(viewModel),
              width: 120, // Specify a width
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              borderColor: Colors.blue, // Use a more visible color
              textStyle: const TextStyle(
                fontSize: 14.0,
                color: Colors.blue, // Match this with borderColor
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        if (!_isPaymentSumValid())
          Padding(
            padding: const EdgeInsets.only(top: AppDimensions.smallPadding),
            child: Text(
              'Payments must equal ${widget.totalCollection.toStringAsFixed(2)} of total collection',
              style: const TextStyle(
                  color: Colors.red, fontSize: AppDimensions.bodyText),
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPaymentMethodDropdown(CollectionViewModel viewModel, int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          // value: widget.paymentMethods[index].paymentMethod?.isNotEmpty == true
          //     ? widget.paymentMethods[index].paymentMethod
          //     : null,
          value:
              _displayedPaymentMethods[index].paymentMethod?.isNotEmpty == true
                  ? _displayedPaymentMethods[index].paymentMethod
                  : null,
          hint: const Text('Select', style: TextStyle(fontSize: 12)),
          items:
              viewModel.dropdownOptions['paymentMethod']?.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis),
                    );
                  }).toList() ??
                  [],
          onChanged: (value) {
            setState(() {
              final updatedPayment = _displayedPaymentMethods[index].copyWith(
                // final updatedPayment = widget.paymentMethods[index].copyWith(
                paymentMethod: value ?? '',
              );
              // widget.paymentMethods[index] = updatedPayment;
              // widget.onPaymentMethodsChanged(widget.paymentMethods);
              _displayedPaymentMethods[index] = updatedPayment;
              widget.onPaymentMethodsChanged(_displayedPaymentMethods);
            });
          },
        ),
      ),
    );
  }

  Widget _buildTypeDropdown(int index) {
    final typeOptions = typeOptionsMap.keys.toList();
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _displayedPaymentMethods[index].type?.isNotEmpty == true
              ? typeOptionsMap.entries
                  .firstWhere(
                      (entry) =>
                          entry.value == _displayedPaymentMethods[index].type,
                      orElse: () => const MapEntry('', ''))
                  .key
              : null,
          hint: const Text('Select', style: TextStyle(fontSize: 12)),
          items: typeOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              final updatedPayment = _displayedPaymentMethods[index].copyWith(
                type: typeOptionsMap[value] ?? '',
              );
              _displayedPaymentMethods[index] = updatedPayment;
              widget.onPaymentMethodsChanged(_displayedPaymentMethods);
            });
          },
        ),
      ),
    );
  }

  // Widget _buildTypeDropdown(int index) {
  //   final typeOptions = typeOptionsMap.keys.toList();
  //   return Padding(
  //     padding: const EdgeInsets.all(2.0),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         isExpanded: true,
  //         value: widget.paymentMethods[index].type?.isNotEmpty == true
  //             ? typeOptionsMap.entries
  //                 .firstWhere(
  //                     (entry) =>
  //                         entry.value == widget.paymentMethods[index].type,
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
  //             final updatedPayment = _displayedPaymentMethods[index].copyWith(
  //               type: typeOptionsMap[value] ?? '',
  //             );
  //             _displayedPaymentMethods[index] = updatedPayment;
  //             widget.onPaymentMethodsChanged(_displayedPaymentMethods);
  //           });
  //         },
  //         // setState(() {
  //         //   final updatedPayment = widget.paymentMethods[index].copyWith(
  //         //     type: typeOptionsMap[value] ?? '',
  //         //   );
  //         //   widget.paymentMethods[index] = updatedPayment;
  //         //   widget.onPaymentMethodsChanged(widget.paymentMethods);
  //         // });
  //         // },
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAmountField(int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        controller: _amountControllers[index],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        ),
        // onChanged: (value) {
        //   setState(() {
        //     final updatedPayment = widget.paymentMethods[index].copyWith(
        //       amount: double.tryParse(value),
        //     );
        //     widget.paymentMethods[index] = updatedPayment;
        //     widget.onPaymentMethodsChanged(widget.paymentMethods);
        //   });
        // },
        onChanged: (value) {
          setState(() {
            final updatedPayment = _displayedPaymentMethods[index].copyWith(
              amount: double.tryParse(value),
            );
            _displayedPaymentMethods[index] = updatedPayment;
            _calculateSumOfPayments();
            widget.onPaymentMethodsChanged(_displayedPaymentMethods);
          });
        },
      ),
    );
  }

  Widget _buildRemarksField(int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        controller: _remarksControllers[index],
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        ),
        // onChanged: (value) {
        //   setState(() {
        //     final updatedPayment = widget.paymentMethods[index].copyWith(
        //       remarks: value,
        //     );
        //     widget.paymentMethods[index] = updatedPayment;
        //     widget.onPaymentMethodsChanged(widget.paymentMethods);
        //   });
        // },
        onChanged: (value) {
          setState(() {
            final updatedPayment = _displayedPaymentMethods[index].copyWith(
              remarks: value,
            );
            _displayedPaymentMethods[index] = updatedPayment;
            widget.onPaymentMethodsChanged(_displayedPaymentMethods);
          });
        },
      ),
    );
  }

  Widget _buildDeleteButton(int index) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red, size: 16),
      onPressed: () => _deletePaymentMethod(index),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  // void _addPaymentMethod(CollectionViewModel viewModel) {
  //   setState(() {
  //     widget.paymentMethods.add(Payment(
  //       paymentMethod: '',
  //       type: '',
  //       amount: null,
  //       remarks: '',
  //       cs_bunit_id: viewModel.getUserBunitId(),
  //     ));
  //     _initControllers();
  //     _calculateSumOfPayments();
  //   });
  // }
  void _addPaymentMethod(CollectionViewModel viewModel) {
    print('PaymentMethodsTable: Adding new payment method');
    setState(() {
      _displayedPaymentMethods.add(Payment(
        paymentMethod: '',
        type: '',
        amount: null,
        remarks: '',
        cs_bunit_id: viewModel.getUserBunitId(),
      ));
      _initControllers();
      _calculateSumOfPayments();
    });
    print(
        'PaymentMethodsTable: Updated _displayedPaymentMethods: $_displayedPaymentMethods');

    widget.onPaymentMethodsChanged(_displayedPaymentMethods);
  }

  // void _deletePaymentMethod(int index) {
  //   setState(() {
  //     widget.paymentMethods.removeAt(index);
  //     _initControllers();
  //     _calculateSumOfPayments();
  //   });
  //   widget.onPaymentMethodsChanged(widget.paymentMethods);
  // }

  void _deletePaymentMethod(int index) {
    print('PaymentMethodsTable: Deleting payment method at index $index');
    setState(() {
      if (_displayedPaymentMethods.length > 1) {
        _displayedPaymentMethods.removeAt(index);
        // _initControllers();
        // _calculateSumOfPayments();
      } else {
        // If it's the last row, clear its contents instead of removing it
        _displayedPaymentMethods[0] = Payment(
          paymentMethod: '',
          type: '',
          amount: null,
          remarks: '',
          cs_bunit_id: Provider.of<CollectionViewModel>(context, listen: false)
              .getUserBunitId(),
        );
        _initControllers();
        _calculateSumOfPayments();
      }
    });
    print(
        'PaymentMethodsTable: Updated _displayedPaymentMethods: $_displayedPaymentMethods');

    widget.onPaymentMethodsChanged(_displayedPaymentMethods);
  }

  void resetTable() {
    print('PaymentMethodsTable: Resetting table');
    setState(() {
      _displayedPaymentMethods = [
        Payment(
          paymentMethod: '',
          type: '',
          amount: null,
          remarks: '',
          cs_bunit_id: Provider.of<CollectionViewModel>(context, listen: false)
              .getUserBunitId(),
        )
      ];
      _initControllers();
      _calculateSumOfPayments();
    });
    print(
        'PaymentMethodsTable: Reset _displayedPaymentMethods: $_displayedPaymentMethods');

    widget.onPaymentMethodsChanged(_displayedPaymentMethods);
  }

  @override
  void dispose() {
    _amountControllers.values.forEach((controller) => controller.dispose());
    _remarksControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
