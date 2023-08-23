import 'package:get_it/get_it.dart';
import 'package:wallet_connect_poc/services/i_scanner_service.dart';
import 'package:wallet_connect_poc/services/scanner_service.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<IScannerService>(ScannerService());
}
