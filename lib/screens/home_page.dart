import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/model/wc_data.dart';
import 'package:wallet_connect_poc/screens/wallet_connect_qr_screen.dart';
import 'package:wallet_connect_poc/service_locator.dart';
import 'package:wallet_connect_poc/utility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wallet_connect_poc/widgets/pairing_details_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Utility {
  final wcData = serviceLocator.get<WCData>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(AppData.homeScreenTitle),
      ),
      body: Center(
        child: Observer(
          builder: (context) => wcData.isLoading
              ? const CircularProgressIndicator()
              : wcData.pairingInfo != null
                  ? const PairingDetailsCard()
                  : const Offstage(),
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
    wcData.clear();
    final Barcode? res = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WalletConnectQRScreen(),
      ),
    );
    if (isValidWCUri(res?.code)) {
      wcData.uri = res!.code;
      wcData.pairConnection();
    } else {
      if (res != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid QR code to pair a connection'),
        ));
      }
    }
  }
}
