import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/mixin/dialog_mixin.dart';
import 'package:wallet_connect_poc/widgets/dialog/dialog.dart';

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
        title: const Text(AppData.scanHeadingText),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
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
          Expanded(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      AppData.qrScanDescription,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
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
