// import 'dart:async';
//
// import 'package:common/common_widgets.dart';
// // import 'package:smine/src/role_sreens/screen_access.dart';
// // import 'package:smine/src/role_sreens/user_role.dart';
//
// class CollectionTab extends StatefulWidget {
//   final UserRole userRole;
//   const CollectionTab({super.key, required this.userRole});
//
//   @override
//   _CollectionTabState createState() => _CollectionTabState();
// }
//
// class _CollectionTabState extends State<CollectionTab>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   CollectionFormModel formModel = CollectionFormModel();
//   late ScreenAccess screenAccess;
//   String? transactionDate = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeUserData();
//     screenAccess = ScreenAccess.forRole(widget.userRole);
//     _tabController = TabController(
//       length: [
//         screenAccess.canAccessEntry,
//         screenAccess.canAccessPayment,
//         screenAccess.canAccessLoading,
//         screenAccess.canAccessExit,
//       ].where((canAccess) => canAccess).length,
//       vsync: this,
//     );
//     _updateTime();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final collectionViewModel =
//           Provider.of<CollectionViewModel>(context, listen: false);
//       collectionViewModel.fetchDropdownOptions();
//     });
//   }
//
//   void _initializeUserData() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<LoginViewModel>().fetchUserIdData();
//     });
//   }
//
//   // void _updateTime() {
//   //   _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//   //     if (mounted) {
//   //       setState(() {
//   //         final DateTime now = DateTime.now();
//   //         final String formattedTime =
//   //             '${now.hour}:${now.minute}:${now.second.toString().padLeft(2, '0')}';
//   //         final String formattedDate = '${now.day}/${now.month}/${now.year}';
//   //         _currentTime = '$formattedTime - $formattedDate';
//   //       });
//   //     }
//   //   });
//   // }
//   // void _updateTime() {
//   //   setState(() {
//   //     final now = DateTime.now();
//   //     formModel.transactionDate =
//   //         '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
//   //   });
//   //   Future.delayed(const Duration(seconds: 1), _updateTime);
//   // }
//   void _updateTime() {
//     if (mounted) {
//       setState(() {
//         final now = DateTime.now();
//         formModel.transactionDate =
//             '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
//       });
//       Future.delayed(const Duration(seconds: 1), _updateTime);
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   TabController _initTabController(ScreenAccess access) {
//     final tabs = [
//       if (access.canAccessEntry) const Tab(text: 'Entry'),
//       if (access.canAccessPayment) const Tab(text: 'Payment'),
//       if (access.canAccessLoading) const Tab(text: 'Loading'),
//       if (access.canAccessExit) const Tab(text: 'Exit'),
//     ];
//
//     return TabController(length: tabs.length, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CollectionViewModel>(
//       builder: (context, viewModel, _) {
//         final userData = viewModel.userData;
//         final name = userData?['name'] as String? ?? 'Unknown';
//         final csRole = userData?['cs_role'] as String? ?? '';
//
//         screenAccess = ScreenAccess.forRole(
//           UserRole.values.firstWhere(
//             (role) =>
//                 role.toString().split('.').last.toLowerCase() ==
//                 csRole.toLowerCase(),
//             orElse: () => UserRole.operator,
//           ),
//         );
//
//         _tabController ??= _initTabController(screenAccess!);
//
//         return Scaffold(
//           appBar: _buildAppBar(name),
//           drawer: _buildDrawer(),
//           body: _buildBody(),
//         );
//       },
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(String name) {
//     return AppBar(
//       toolbarHeight: 60,
//       elevation: 0,
//       backgroundColor: HexColor(whiteColor),
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         ),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               name,
//               style: TextStyle(color: HexColor(blackColor), fontSize: 16),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               formModel.transactionDate ?? '',
//               style: TextStyle(color: HexColor(blackColor), fontSize: 14),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(color: HexColor(blueColor)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const Text(
//                   'Menu',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Welcome, ${Provider.of<CollectionViewModel>(context).userData?['name'] ?? 'User'}',
//                   style: const TextStyle(color: Colors.white70, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.red),
//             title: const Text('Logout', style: TextStyle(fontSize: 16)),
//             onTap: () {
//               clearUserInfo();
//               callWebLogin(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBody() {
//     return Column(
//       children: [
//         TabBar(
//           controller: _tabController,
//           tabs: [
//             if (screenAccess!.canAccessEntry) const Tab(text: 'Entry'),
//             if (screenAccess!.canAccessPayment) const Tab(text: 'Payment'),
//             if (screenAccess!.canAccessLoading) const Tab(text: 'Loading'),
//             if (screenAccess!.canAccessExit) const Tab(text: 'Exit'),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: [
//               if (screenAccess!.canAccessEntry) const EntryTab(),
//               if (screenAccess!.canAccessPayment) const PaymentTab(),
//               if (screenAccess!.canAccessLoading) const LoadingTab(),
//               if (screenAccess!.canAccessExit) const ExitTab(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
