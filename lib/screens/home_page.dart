import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/model/wc_pairing_info.dart';
import 'package:wallet_connect_poc/screens/wallet_connect_qr_screen.dart';
import 'package:wallet_connect_poc/service_locator.dart';
import 'package:wallet_connect_poc/utility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Utility {
  final pairingInfo = serviceLocator.get<WCPairingInfo>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Observer(
          builder: (context) => pairingInfo.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (pairingInfo.uri != null) Text(pairingInfo.uri!),
                    if (pairingInfo.pairingInfo != null) ...[
                      Text(pairingInfo.pairingInfo!.topic),
                      Text(pairingInfo.pairingInfo!.expiry.toString()),
                      Text(pairingInfo.pairingInfo!.relay.protocol),
                    ]
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanQrCode,
        tooltip: AppData.scanToolTip,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void scanQrCode() async {
    pairingInfo.clear();
    final Barcode res = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WalletConnectQRScreen(),
      ),
    );
    if (isValidWCUri(res.code)) {
      pairingInfo.uri = res.code;
      pairingInfo.pairConnection();
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid QR code to pair the connection'),
        ));
      }
    }
  }
}
