import 'package:common/common_widgets.dart';

class SharedWidgetsExpense {
  static PreferredSizeWidget buildAppBar(String name, String? date) {
    // print("SharedWidgets: Building AppBar with name: $name"); // Log the name being used in AppBar
    return AppBar(
      toolbarHeight: 60,
      elevation: 0,
      backgroundColor: HexColor(whiteColor),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              // 'Welcome, $name'
              style: TextStyle(color: HexColor(blackColor), fontSize: 16),
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
                  'Menu',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
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
      // final localDB = LocalDB();
      // await localDB.clearUserData();
      // Navigate to login screen using GoRouter
      GoRouter.of(context).go('/login');
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during logout: $e')),
      );
    }
  }
}
