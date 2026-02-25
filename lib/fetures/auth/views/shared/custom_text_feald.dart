import 'package:flutter/material.dart';

class CustomTextFeald extends StatefulWidget {
  CustomTextFeald({
    super.key,
    required this.hint,
    this.isPassword = false,
    required this.controller,
  });
  String hint;
  bool isPassword;
  TextEditingController controller;

  @override
  State<CustomTextFeald> createState() => _CustomTextFealdState();
}

class _CustomTextFealdState extends State<CustomTextFeald> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggelPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.hint}';
        }
        return null;
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  _toggelPassword();
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
