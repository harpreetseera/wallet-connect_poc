import 'package:flutter/material.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/screens/home_page.dart';
import 'package:wallet_connect_poc/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const WCApp());
}

class WCApp extends StatelessWidget {
  const WCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppData.appTitle,
      theme: AppData.appTheme,
      home: const HomeScreen(title: AppData.homeScreenTitle),
    );
  }
}
