import 'package:mobx/mobx.dart';
import 'package:wallet_connect_poc/service_locator.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/web3wallet/web3wallet.dart';
part 'wc_data.g.dart';


///Contains the details of the pairing request for a wallet connection
class WCData = WCDataBase with _$WCData;

abstract class WCDataBase with Store {
  WCDataBase({
    this.uri,
    this.isLoading = false,
    this.pairingInfo,
  });

  @observable
  String? uri;

  @observable
  bool isLoading;

  @observable
  PairingInfo? pairingInfo;

  @computed
  bool get isPairingDetailAvailable => pairingInfo != null;
  
  /// Parses the passed Uri and establishes a pairing connection withe corresponsing uri.
  /// Internally manges the loading state
  @action
  Future<void> pairConnection() async {
    final actualUri = Uri.parse(uri!);
    isLoading = true;
    final pairingResult =
        await serviceLocator.get<Web3Wallet>().pair(uri: actualUri);
    isLoading = false;
    pairingInfo = pairingResult;
  }

  /// Action to clear the uri and pairing info.
  /// Majorly used when the wallet connect QR button is pressed.
  @action
  Future<void> clear() async {
    uri = null;
    pairingInfo = null;
  }
}
