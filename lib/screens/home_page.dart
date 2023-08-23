import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/screens/wallet_connect_qr_screen.dart';
import 'package:wallet_connect_poc/view_model/home_screeen_vm.dart';

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
            builder: (context) => WalletConnectQRScreen(),
          ));
          print(res.code.toString());
        },
        tooltip: AppData.scanToolTip,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
