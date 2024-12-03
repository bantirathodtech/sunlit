// filename: collection_screen_csrole.dart

import 'dart:async';

import 'package:common/common_widgets.dart';

import '../../core/util/date_time_utils.dart';
import '../sharedWidgets/shared_widgets.dart';
// import '../viewmodels/collection_viewmodel.dart';
// import '../viewmodels/login_viewmodel.dart';

class CollectionTab extends StatefulWidget {
  final UserRole userRole;

  const CollectionTab({Key? key, required this.userRole}) : super(key: key);

  @override
  _CollectionTabState createState() => _CollectionTabState();
}

class _CollectionTabState extends State<CollectionTab>
    with SingleTickerProviderStateMixin {
  late CollectionFormModel collectionFormModel;
  late TabController _tabController;
  late ScreenAccess _screenAccess;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    collectionFormModel = CollectionFormModel();
    _initializeTabController();
    _initializeData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimeUpdates();
      context.read<CollectionViewModel>().fetchDropdownOptions();
    });
  }

  void _initializeTabController() {
    final loginViewModel = context.read<LoginViewModel>();
    final userRole = getUserRole(loginViewModel.userIdData1.csRole ?? '');
    _screenAccess = ScreenAccess.forRole(userRole);

    final tabs = _buildTabs();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  UserRole getUserRole(String csRole) {
    switch (csRole.toLowerCase()) {
      case 'operator':
        return UserRole.operator;
      case 'cashier':
        return UserRole.cashier;
      case 'loader':
        return UserRole.loader;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.admin;
    }
  }

  Future<void> _initializeData() async {
    // Implement if needed
  }

  void _startTimeUpdates() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    if (!mounted) return;
    final now = DateTime.now();
    collectionFormModel.dateordered = DateTimeUtils.formatForDisplay(now);
    if (mounted) {
      context.read<CollectionViewModel>().updateTransactionDate(now);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CollectionViewModel, LoginViewModel>(
      builder: (context, collectionViewModel, loginViewModel, _) {
        final name = collectionViewModel.name;
        final userName = collectionViewModel.userName;

        return Scaffold(
          appBar: SharedWidgetsCollection.buildAppBar(
            name,
            collectionFormModel.dateordered,
            _buildTabs(),
            _tabController,
          ),
          drawer: SharedWidgetsCollection.buildDrawer(context, userName),
          body: TabBarView(
            controller: _tabController,
            children: _buildTabViews(),
          ),
        );
      },
    );
  }

  List<Widget> _buildTabs() {
    return [
      if (_screenAccess.canAccessEntry) const Tab(text: 'Entry'),
      if (_screenAccess.canAccessPayment) const Tab(text: 'Payment'),
      if (_screenAccess.canAccessLoading) const Tab(text: 'Loading'),
      if (_screenAccess.canAccessExit) const Tab(text: 'Exit'),
    ];
  }

  List<Widget> _buildTabViews() {
    return [
      if (_screenAccess.canAccessEntry) const EntryTab(),
      if (_screenAccess.canAccessPayment) const PaymentTab(),
      if (_screenAccess.canAccessLoading) const LoadingTab(),
      if (_screenAccess.canAccessExit) const ExitTab(),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer?.cancel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CollectionViewModel>().deactivate();
      }
    });
    super.dispose();
  }
}

// // filename: collection_screen_csrole.dart
//
// import 'dart:async';
//
// import 'package:common/common_widgets.dart';
//
// import '../../core/util/date_time_utils.dart';
// import '../sharedWidgets/shared_widgets.dart';
//
// class CollectionTab extends StatefulWidget {
//   final UserRole userRole;
//
//   const CollectionTab({super.key, required this.userRole});
//
//   @override
//   _CollectionTabState createState() => _CollectionTabState();
// }
//
// class _CollectionTabState extends State<CollectionTab>
//     with SingleTickerProviderStateMixin {
//   late CollectionFormModel
//       collectionFormModelFormModel; //to be used for the model data reusing
//   late AccessToken accessToken;
//   TabController? _tabController;
//   late ScreenAccess _screenAccess;
//   Timer? _timer;
//
//   String get currentTransactionDate =>
//       collectionFormModelFormModel.dateordered ?? '';
//
//   @override
//   void initState() {
//     super.initState();
//     collectionFormModelFormModel = CollectionFormModel();
//     _initializeTabController();
//     _initializeData();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _startTimeUpdates();
//       Provider.of<CollectionViewModel>(context, listen: false)
//           .fetchDropdownOptions();
//       // final loginViewModel =
//       //     Provider.of<LoginViewModel>(context, listen: false);
//       // loginViewModel
//       //     .repositoryUserIdDataToViewModel(accessToken.userId.toString());
//       // final loginViewModel =
//       //     Provider.of<LoginViewModel>(context, listen: false);
//       // loginViewModel.fetchUserIdData(accessToken.userId.toString());
//     });
//   }
//
//   void _initializeTabController() {
//     final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
//     final userRole = getUserRole(loginViewModel.userIdData1.csRole ?? '');
//     _screenAccess = ScreenAccess.forRole(userRole);
//
//     final tabs = [
//       if (_screenAccess.canAccessEntry) const Tab(text: 'Entry'),
//       if (_screenAccess.canAccessPayment) const Tab(text: 'Payment'),
//       if (_screenAccess.canAccessLoading) const Tab(text: 'Loading'),
//       if (_screenAccess.canAccessExit) const Tab(text: 'Exit'),
//     ];
//
//     _tabController = TabController(length: tabs.length, vsync: this);
//   }
//
//   UserRole getUserRole(String csRole) {
//     switch (csRole.toLowerCase()) {
//       case 'operator':
//         return UserRole.operator;
//       case 'cashier':
//         return UserRole.cashier;
//       case 'loader':
//         return UserRole.loader;
//       case 'admin':
//         return UserRole.admin;
//       default:
//         return UserRole.admin;
//     }
//   }
//
//   Future<void> _initializeData() async {
//     // LocalDB localDB = LocalDB();
//     // accessToken = (await localDB.loadAccessToken())!;
//   }
//
//   void _startTimeUpdates() {
//     _updateTime();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
//   }
//
//   // void _updateTime() {
//   //   if (mounted) {
//   //     setState(() {
//   //       final now = DateTime.now();
//   //       collectionFormModelFormModel.dateordered = _formatDateTime(now);
//   //       Provider.of<CollectionViewModel>(context, listen: false)
//   //           .updateTransactionDate(collectionFormModelFormModel.dateordered!);
//   //     });
//   //   }
//   // }
//   // void _updateTime() {
//   //   if (mounted) {
//   //     setState(() {
//   //       final now = DateTime.now();
//   //       collectionFormModelFormModel.dateordered =
//   //           DateTimeUtils.formatForDisplay(now);
//   //       Provider.of<CollectionViewModel>(context, listen: false)
//   //           .updateTransactionDate(now);
//   //     });
//   //   }
//   // }
//   void _updateTime() {
//     if (!mounted) return;
//     final now = DateTime.now();
//     collectionFormModelFormModel.dateordered =
//         DateTimeUtils.formatForDisplay(now);
//     if (mounted) {
//       Provider.of<CollectionViewModel>(context, listen: false)
//           .updateTransactionDate(now);
//     }
//   }
//
//   // String _formatDateTime(DateTime dateTime) {
//   //   final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
//   //   final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
//   //   return '${dateTime.year}-'
//   //       '${dateTime.month.toString().padLeft(2, '0')}-'
//   //       '${dateTime.day.toString().padLeft(2, '0')} '
//   //       '${hour.toString().padLeft(2, '0')}:'
//   //       '${dateTime.minute.toString().padLeft(2, '0')} '
//   //       '$amPm';
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<CollectionViewModel, LoginViewModel>(
//       builder: (context, collectionViewModel, loginViewModel, _) {
//         final name = collectionViewModel.name;
//         final userName = collectionViewModel.userName;
//
//         return Scaffold(
//           appBar: SharedWidgetsCollection.buildAppBar(
//             name,
//             collectionFormModel.dateordered,
//             _buildTabs(),
//             _tabController,
//           ),
//           drawer: SharedWidgetsCollection.buildDrawer(context, userName),
//           body: TabBarView(
//             controller: _tabController,
//             children: _buildTabViews(),
//           ),
//         );
//         // return Scaffold(
//         //   appBar: SharedWidgetsCollection.buildAppBar(
//         //       name, collectionFormModelFormModel.dateordered),
//         //   drawer: SharedWidgetsCollection.buildDrawer(context, userName),
//         //   body: _buildBody(),
//         // );
//       },
//     );
//   }
//
//   List<Widget> _buildTabs() {
//     return [
//       if (_screenAccess.canAccessEntry) const Tab(text: 'Entry'),
//       if (_screenAccess.canAccessPayment) const Tab(text: 'Payment'),
//       if (_screenAccess.canAccessLoading) const Tab(text: 'Loading'),
//       if (_screenAccess.canAccessExit) const Tab(text: 'Exit'),
//     ];
//   }
//
//   List<Widget> _buildTabViews() {
//     return [
//       if (_screenAccess.canAccessEntry) const EntryTab(),
//       if (_screenAccess.canAccessPayment) const PaymentTab(),
//       if (_screenAccess.canAccessLoading) const LoadingTab(),
//       if (_screenAccess.canAccessExit) const ExitTab(),
//     ];
//   }
//
//   Widget _buildBody() {
//     return Column(
//       children: [
//         TabBar(
//           controller: _tabController,
//           tabs: _buildTabs(),
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: _buildTabViews(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // List<Widget> _buildTabs() {
//   //   return [
//   //     if (_screenAccess.canAccessEntry) const Tab(text: 'Entry'),
//   //     if (_screenAccess.canAccessPayment) const Tab(text: 'Payment'),
//   //     if (_screenAccess.canAccessLoading) const Tab(text: 'Loading'),
//   //     if (_screenAccess.canAccessExit) const Tab(text: 'Exit'),
//   //   ];
//   // }
//   //
//   // List<Widget> _buildTabViews() {
//   //   return [
//   //     if (_screenAccess.canAccessEntry) const EntryTab(),
//   //     if (_screenAccess.canAccessPayment) const PaymentTab(),
//   //     if (_screenAccess.canAccessLoading) const LoadingTab(),
//   //     if (_screenAccess.canAccessExit) const ExitTab(),
//   //   ];
//   // }
//
//   @override
//   void dispose() {
//     _tabController?.dispose();
//     _timer?.cancel(); // Make sure this line is present
//     // Deactivate the view model
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         Provider.of<CollectionViewModel>(context, listen: false).deactivate();
//       }
//     });
//     super.dispose();
//   }
// }
