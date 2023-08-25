import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_connect_poc/app_data.dart';

/// Permission dialog to ask user for camera permission.
void showPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      actions: [
        CupertinoDialogAction(
          isDefaultAction: false,
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text(AppData.cancelText),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () async {
            Navigator.of(context).pop();
            AppSettings.openAppSettings();
          },
          child: const Text(AppData.settingsText),
        ),
      ],
      title: const Text(AppData.cameraAccessText),
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(AppData.cameraAccessDescText),
      ),
    ),
  );
}
