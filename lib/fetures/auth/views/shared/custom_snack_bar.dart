import 'package:flutter/material.dart';

SnackBar customSnackBar(String message) {
  return SnackBar(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    margin: EdgeInsets.only(bottom: 30, left: 20, right: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 5,
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.none,
    backgroundColor: Colors.redAccent,

    content: SizedBox(
      height: 20,
      width: 20,
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(message, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}
