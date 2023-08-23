import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_connect_poc/mixin/dialog_mixin.dart';

class WalletConnectQRScreen extends StatefulWidget {
  const WalletConnectQRScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WalletConnectQRScreenState();
}

class _WalletConnectQRScreenState extends State<WalletConnectQRScreen>
    with DialogMixin {
  Barcode? result;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scan QR to Pair'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width / 1.6,
                ),
                onPermissionSet: (qrViewController, isPermissionGiven) =>
                    _onPermissionSet(
                  context,
                  qrViewController,
                  isPermissionGiven,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                    "place your QR code withiun the given area to pair with the dapp")
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      goBackWithResult(scanData);
    });
  }

  void goBackWithResult(Barcode? scanData) {
    result = scanData;
    controller.dispose();
    Navigator.of(context).pop(result);
  }

  void _onPermissionSet(
    BuildContext context,
    QRViewController qrViewController,
    bool isPermissionGiven,
  ) {
    if (!isPermissionGiven) {
      showPermissionDialog(context);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

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
          child: const Text("Cancel"),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () async {
            Navigator.of(context).pop();
            AppSettings.openAppSettings();
          },
          child: const Text("Settings"
              // style: textStyle,
              ),
        ),
      ],
      title: const Text("Camera Access"),
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("Camera Access description"),
      ),
    ),
  );
}
