import 'package:flutter/material.dart';

// Custom Button Widget
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;

  CustomButton({
    required this.label,
    required this.onPressed,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
      ),
      child: Text(
        label,
        style: textStyle ?? Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

// Custom Input Field Widget
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputAction? textInputAction;

  CustomTextField({
    required this.label,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

// Custom Card Widget
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  CustomCard({
    required this.child,
    this.padding,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).cardColor,
      margin: margin ?? EdgeInsets.all(8.0),
      child: Padding(
        padding: padding ?? EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

// Custom AppBar Widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  CustomAppBar({
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Custom Loader Widget
class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

// Custom Dialog Widget
class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  CustomDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
//Purpose: Contains reusable custom widgets and UI components to standardize the UI.
// Usage: Used to create and reuse custom UI components across the app.
