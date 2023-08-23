import 'package:flutter/material.dart';

class AppData {
  static const String scanToolTip = 'Scan QR to pair';

  static const String appTitle = 'WC Pairing';

  static const String homeScreenTitle = 'Wallet Connect Pairing';

  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
}
