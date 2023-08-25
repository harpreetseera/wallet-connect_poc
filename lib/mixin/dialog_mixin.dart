import 'package:flutter/material.dart';
import 'package:wallet_connect_poc/size_config.dart';

///Mixin helper to show dialogs such as loaders 
mixin DialogMixin<T extends StatefulWidget> on State<T> {
  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.mediumBorderRadius)),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  void removeLoader(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
