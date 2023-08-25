import 'package:get_it/get_it.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/model/wc_data.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  serviceLocator.registerSingleton<WCData>(WCData());
  final wcClient = await getWcClient();
  serviceLocator.registerSingleton<Web3Wallet>(wcClient);
}

getWcClient() async {
  Web3Wallet wcClient = await Web3Wallet.createInstance(
    relayUrl: AppData.wcRelayUrl,
    projectId: AppData.projectId,
    metadata: const PairingMetadata(
      name: AppData.wcPairingName,
      description: AppData.wcPairingDesc,
      url: AppData.wcAppUrl,
      icons: [AppData.wcAppIconUrl],
    ),
  );
  return wcClient;
}
