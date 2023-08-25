import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_connect_poc/screens/home_screen.dart';
import 'package:wallet_connect_poc/service_locator.dart';

void main() {
  group("Floating Action button Test cases", () {
    SharedPreferences.setMockInitialValues({});
    setupServiceLocator();

    testWidgets("Fab is pumped ", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );
      final widgetFinder = find.byType(FloatingActionButton);
      expect(widgetFinder, findsOneWidget);
    });
    testWidgets("Fab is pumped and has expected child", (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: HomeScreen()),
      );
      final widgetFinder = find.byType(FloatingActionButton);
      expect(
        widgetTester
            .firstWidget<FloatingActionButton>(widgetFinder)
            .child
            .runtimeType,
        Icon,
      );
    });
  });
}
