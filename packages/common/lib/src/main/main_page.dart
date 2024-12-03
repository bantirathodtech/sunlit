import '../../common_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [];
  UserRole _userRole = UserRole.operator;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeUserRole();
  }

  void _initializeUserRole() {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    _userRole = _getUserRole(loginViewModel.userIdData1.csRole ?? '');

    setState(() {
      _pages = [
        CollectionTab(userRole: _userRole),
        if (_canAccessExpense()) ExpenseFormScreen(userRole: _userRole),
        const InfoScreen(),
      ];
    });
  }

  UserRole _getUserRole(String csRole) {
    switch (csRole.toLowerCase()) {
      case 'cashier':
        return UserRole.cashier;
      case 'loader':
        return UserRole.loader;
      case 'operator':
        return UserRole.operator;
      default:
        return UserRole.admin;
    }
  }

  bool _canAccessExpense() {
    return _userRole == UserRole.admin || _userRole == UserRole.cashier;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.collections), label: 'Collection'),
        if (_canAccessExpense())
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Expenses'),
        const BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    );
  }
}
