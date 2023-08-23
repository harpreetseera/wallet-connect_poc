import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/screens/wallet_connect_qr_screen.dart';
import 'package:wallet_connect_poc/view_model/home_screeen_vm.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/web3wallet/web3wallet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenVM = HomeScreenVM();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // homeScreenVM.scanQrCode();
          final Barcode res =
              await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const WalletConnectQRScreen(),
          ));
          pairWC(res.code!);
        },
        tooltip: AppData.scanToolTip,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void pairWC(String code) async {
    final uri = Uri.parse(code);
    print("\n\nUr: ${uri.toString()}");
    Web3Wallet wcClient = await Web3Wallet.createInstance(
      // relayUrl: uri.host,
      relayUrl: 'wss://relay.walletconnect.com',
      // 'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
      projectId: '123',
      metadata: const PairingMetadata(
        name: 'Wallet (Responder)',
        description: 'A wallet that can be requested to sign transactions',
        url: 'https://walletconnect.com',
        icons: ['https://avatars.githubusercontent.com/u/37784886'],
      ),
    );
    final pairingInfo = await wcClient.pair(uri: uri);
    print('\n\n Pairing info->\n topic: ${pairingInfo.topic}');
    print('\n expiry: ${pairingInfo.expiry}');
    print('\n relay Data: ${pairingInfo.relay.data}');
    print('\n relay protocol: ${pairingInfo.relay.protocol}');
  }
}
