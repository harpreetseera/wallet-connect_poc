import 'package:flutter/material.dart';

mixin DialogMixin<T extends StatefulWidget> on State<T> {
  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }

  void removeLoader(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
