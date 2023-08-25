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
  /// Fetches the required data through dependency injection
  final wcData = serviceLocator.get<WCData>();

  @override
  Widget build(BuildContext context) {
    final appBarBgColor = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        title: const Text(AppData.homeScreenTitle),
      ),
      body: Center(
        child: Observer(
          builder: (context) {
            if (wcData.isLoading) {
              return const CircularProgressIndicator();
            } else {
              if (wcData.isPairingDetailAvailable) {
                return const PairingDetailsCard();
              } else {
                return const Offstage();
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: processQrCodeScanning,
        tooltip: AppData.scanToolTip,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void processQrCodeScanning() async {
    wcData.clear();
    final Barcode? res = await scanQr();
    if (isValidWCUri(res?.code)) {
      wcData.uri = res!.code;
      wcData.pairConnection();
    } else {
      if (res != null && context.mounted) {
        showErrorMsg();
      }
    }
  }

  /// Loads a snackbar with the error msg
  void showErrorMsg() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(AppData.invalidQRMsg),
    ));
  }

  Future<Barcode?> scanQr() async {
    final qrscanResult = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WalletConnectQRScreen(),
      ),
    );
    return qrscanResult;
  }
}
