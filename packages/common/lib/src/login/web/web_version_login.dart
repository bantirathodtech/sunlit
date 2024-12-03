import 'package:common/common_widgets.dart';

class WebVersionLoginPage extends StatefulWidget {
  const WebVersionLoginPage({Key? key}) : super(key: key);

  @override
  State<WebVersionLoginPage> createState() => _WebVersionLoginPageState();
}

class _WebVersionLoginPageState extends State<WebVersionLoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();
  bool _obscured = true;
  String _versionNumber = "";

  @override
  void initState() {
    super.initState();
    _getVersionNumber();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: HexColor(whiteColor),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                const SizedBox(height: 50),
                _buildUsernameField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 40),
                _buildLoginButton(loginViewModel),
                const SizedBox(height: 7),
                _buildVersionText(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Image(
      image: AssetImage("packages/common/assets/images/my_cw.png"),
      width: 260,
      height: 60,
    );
  }

  Widget _buildUsernameField() {
    return SizedBox(
      height: 50,
      width: 315,
      child: TextField(
        controller: _userNameController,
        decoration: InputDecoration(
          fillColor: HexColor(background),
          filled: true,
          hintText: 'Username',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset(
              "packages/common/assets/images/login_user.svg",
              width: 12,
              height: 12,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
        style: textStyle(blackColor, 18, FontWeight.w500),
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      height: 50,
      width: 315,
      child: TextField(
        controller: _passwordController,
        obscureText: _obscured,
        focusNode: _textFieldFocusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: HexColor(background),
          hintText: 'Password',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset(
              "packages/common/assets/images/password_icon.svg",
              width: 12,
              height: 12,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                _obscured ? Icons.visibility_off : Icons.visibility,
                size: 22,
                color: HexColor(blackColor),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
        style: textStyle(blackColor, 18, FontWeight.w500),
      ),
    );
  }

  Widget _buildLoginButton(LoginViewModel loginViewModel) {
    return ElevatedButton(
      onPressed: () => _handleLogin(loginViewModel),
      style: ElevatedButton.styleFrom(
        backgroundColor: HexColor(blackColor),
        foregroundColor: Colors.white,
        fixedSize: const Size(225, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: _buildButtonChild(loginViewModel),
    );
  }

  Widget _buildButtonChild(LoginViewModel loginViewModel) {
    return loginViewModel.isLoading
        ? circleLoadingIndicator()
        : blackTextWidgetSmall("LOGIN", whiteColor, 14, FontWeight.w700);
  }

  Widget _buildVersionText() {
    return blackTextWidgetSmall(
        "Version:  $_versionNumber", blackColor, 14, FontWeight.w500);
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (_textFieldFocusNode.hasPrimaryFocus) return;
      _textFieldFocusNode.canRequestFocus = false;
    });
  }

  void _handleLogin(LoginViewModel loginViewModel) {
    if (_userNameController.text.isEmpty) {
      showSnackBar("Username field shouldn't be empty");
    } else if (_passwordController.text.isEmpty) {
      showSnackBar("Password field shouldn't be empty");
    } else {
      loginViewModel.getLoginData(
          _userNameController.text, _passwordController.text, context);
    }
  }

  Future<void> _getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _versionNumber = packageInfo.version;
    });
  }
}
