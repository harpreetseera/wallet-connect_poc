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
              : pairingInfo.pairingInfo != null
                  ? Column(
                      children: <Widget>[
                        Card(
                          margin: const EdgeInsets.all(16),
                          color: Theme.of(context).colorScheme.background,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: Text(
                                  "Pairing Details",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                ),
                              ),
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.1),
                              ),
                              PairingProperties(
                                property: "Uri",
                                value: pairingInfo.uri,
                              ),
                              PairingProperties(
                                property: "Topic",
                                value: pairingInfo.pairingInfo!.topic,
                              ),
                              PairingProperties(
                                property: "Expiry",
                                value:
                                    pairingInfo.pairingInfo!.expiry.toString(),
                              ),
                              PairingProperties(
                                property: "Relay Protocol",
                                value: pairingInfo.pairingInfo!.relay.protocol,
                              ),
                              PairingProperties(
                                property: "Relay Data",
                                value: pairingInfo.pairingInfo!.relay.data,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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
    pairingInfo.clear();
    final Barcode? res = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WalletConnectQRScreen(),
      ),
    );
    if (isValidWCUri(res?.code)) {
      pairingInfo.uri = res!.code;
      pairingInfo.pairConnection();
    } else {
      if (res != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid QR code to pair a connection'),
        ));
      }
    }
  }
}

class PairingProperties extends StatelessWidget {
  final String property;
  final String? value;

  const PairingProperties(
      {super.key, required this.property, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: SelectableText.rich(
        TextSpan(
          text: "$property - ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 16,
          ),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
