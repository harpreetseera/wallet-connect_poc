import 'package:get_it/get_it.dart';
import 'package:wallet_connect_poc/model/wc_pairing_info.dart';
import 'package:wallet_connect_poc/services/i_scanner_service.dart';
import 'package:wallet_connect_poc/services/scanner_service.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() async {
  serviceLocator.registerSingleton<IScannerService>(ScannerService());
  serviceLocator.registerSingleton<WCPairingInfo>(WCPairingInfo());
  final wcClient = await getWcClient();
  serviceLocator.registerSingleton<Web3Wallet>(wcClient);
}

getWcClient() async {
  Web3Wallet wcClient = await Web3Wallet.createInstance(
    relayUrl: 'wss://relay.walletconnect.com',
    projectId: '',
    metadata: const PairingMetadata(
      name: 'WC Pairing',
      description: 'A wallet that can be requested to sign transactions',
      url: 'https://walletconnect.com',
      icons: ['https://avatars.githubusercontent.com/u/37784886'],
    ),
  );
  return wcClient;
}
