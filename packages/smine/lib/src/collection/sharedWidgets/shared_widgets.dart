// filename: shared_widgets.dart

import 'package:common/common_widgets.dart';

class SharedWidgetsCollection {
  static PreferredSizeWidget buildAppBar(
    String name,
    String? transactionDate,
    List<Widget> tabs,
    TabController tabController,
  ) {
    return AppBar(
      toolbarHeight: 60,
      elevation: 0,
      backgroundColor: HexColor(whiteColor),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: HexColor(blackColor)),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                  color: HexColor(blackColor),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              transactionDate ?? '',
              style: TextStyle(color: HexColor(blackColor), fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: TabBar(
          controller: tabController,
          tabs: tabs,
          labelColor: HexColor(greenColor),
          unselectedLabelColor: HexColor(greyColor),
          indicatorColor: HexColor(greenColor),
          indicatorWeight: 3,
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          isScrollable: false, // This ensures tabs are evenly distributed
          labelPadding: EdgeInsets.zero, // Removes default padding
          indicatorSize:
              TabBarIndicatorSize.tab, // Makes indicator full width of the tab
          // indicator: BoxDecoration(
          //   borderRadius: BorderRadius.circular(
          //       60), // Rounded corners for the selected tab
          //   color: HexColor(greyColor), // Background color of the selected tab
          // ),
        ),
      ),
    );
  }

  static Widget buildDrawer(BuildContext context, String name) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: HexColor(greenColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome, $name',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(fontSize: 16)),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  static void logout(BuildContext context) async {
    try {
      GoRouter.of(context).go('/login');
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during logout: $e')),
      );
    }
  }
}

class SharedWidgetsExpense {
  static PreferredSizeWidget buildAppBar(String name, String? date) {
    return AppBar(
      elevation: 0,
      backgroundColor: HexColor(whiteColor),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: HexColor(blackColor)),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                  color: HexColor(blackColor),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              date ?? '',
              style: TextStyle(color: HexColor(blackColor), fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildDrawer(BuildContext context, String name) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: HexColor(blueColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Expense Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome, $name',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(fontSize: 16)),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  static void logout(BuildContext context) async {
    try {
      // Implement your logout logic here
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during logout: $e')),
      );
    }
  }
}

// import 'package:common/common_widgets.dart';
//
// class SharedWidgetsCollection {
//   static PreferredSizeWidget buildAppBar(String name, String? transactionDate) {
//     // print("SharedWidgets: Building AppBar with name: $name"); // Log the name being used in AppBar
//     return AppBar(
//       toolbarHeight: 60,
//       elevation: 0,
//       backgroundColor: HexColor(whiteColor),
//       leading: Builder(
//         builder: (context) => IconButton(
//           icon: const Icon(Icons.menu, color: Colors.black),
//           onPressed: () => Scaffold.of(context).openDrawer(),
//         ),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               name,
//               // 'Welcome, $name'
//               style: TextStyle(color: HexColor(blackColor), fontSize: 16),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               transactionDate ?? '',
//               style: TextStyle(color: HexColor(blackColor), fontSize: 14),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static Widget buildDrawer(BuildContext context, String name) {
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
//                   'Welcome, $name',
//                   style: const TextStyle(color: Colors.white70, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.red),
//             title: const Text('Logout', style: TextStyle(fontSize: 16)),
//             onTap: () => logout(context),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static void logout(BuildContext context) async {
//     try {
//       // final localDB = LocalDB();
//       // await localDB.clearUserData();
//       // Navigate to login screen using GoRouter
//       GoRouter.of(context).go('/login');
//     } catch (e) {
//       print('Error during logout: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error during logout: $e')),
//       );
//     }
//   }
// }
