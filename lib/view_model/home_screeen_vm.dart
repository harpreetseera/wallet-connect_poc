import 'package:wallet_connect_poc/service_locator.dart';
import 'package:wallet_connect_poc/services/i_scanner_service.dart';

class HomeScreenVM {
  final IScannerService iScannerService = serviceLocator.get<IScannerService>();
  HomeScreenVM();

  void scanQrCode() async {
    iScannerService.scanQrCode();
  }
}
