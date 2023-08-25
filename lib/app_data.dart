import 'package:flutter/material.dart';

class AppData {
  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  static const String scanToolTip = 'Scan QR to pair';

  static const String appTitle = 'WC Pairing';

  static const String homeScreenTitle = 'Wallet Connect Pairing';

  static const String invalidQRMsg = 'Invalid QR code to pair a connection';

  static const String uriText = "Uri";

  static const String topicText = "Topic";

  static const String expiryText = "Expiry";

  static const String relayProtocolText = "Relay Protocol";

  static const String relayDataText = "Relay Data";

  static const String pairingDetailsText = "Pairing Details";

  /// Wallet connect configs
  static const String wcRelayUrl = 'wss://relay.walletconnect.com';

  static const String projectId = "Dummy123";

  static const String wcPairingName = 'WC Pairing';

  static const String wcPairingDesc =
      'A wallet that can be requested to sign transactions';

  static const String wcAppUrl = 'https://walletconnect.com';

  static const String wcAppIconUrl =
      'https://avatars.githubusercontent.com/u/37784886';
}
