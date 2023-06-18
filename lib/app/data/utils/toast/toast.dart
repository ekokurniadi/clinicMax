import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  const Toast._();

  static Future<void> showErrorToast(String message,
      {ToastGravity? gravity = ToastGravity.BOTTOM}) async {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      gravity: gravity,
    );
  }

  static Future<void> showSuccessToast(String message,
      {ToastGravity? gravity = ToastGravity.BOTTOM}) async {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      gravity: gravity,
    );
  }
}
