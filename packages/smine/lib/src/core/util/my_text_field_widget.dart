import 'dart:async';

import 'package:common/common_widgets.dart';

import 'form_fields.dart';

class MyTextFieldWidget extends StatefulWidget {
  @override
  _MyTextFieldWidgetState createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _controller.addListener(() {
      _onTextChanged();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 2), () {
      if (_controller.text.isNotEmpty && !_controller.text.contains('.')) {
        setState(() {
          _controller.text += '.0';
          _controller.selection =
              TextSelection.collapsed(offset: _controller.text.length);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      inputFormatters: [doubleInputFormatter],
      decoration: const InputDecoration(
        labelText: 'Enter Number',
        border: OutlineInputBorder(),
      ),
    );
  }
}
