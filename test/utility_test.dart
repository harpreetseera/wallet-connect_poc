import 'package:test/test.dart';
import 'package:wallet_connect_poc/utility.dart';
import 'package:flutter/material.dart';

class Testing with Utility {}

void main() {
  group("Test cases for Utility mixin", () {
    test("Test a valid Uri", () {
      const uri =
          "wc:15c0c3d75a3a47d58bc198161a150a08c64bc7b442f5dc700379c5ea2b762792@2?relay-protocol=irn&symKey=61cad7567663a45f188c0ee7fe99b7e8e8d8cccab095d776ea107dc7626451fb";
      final output = Testing().isValidWCUri(uri);
      const expectedValue = true;
      expect(output, expectedValue);
    });

    test("Test an inValid Uri", () {
      const uri = "Dummy Uri";
      final output = Testing().isValidWCUri(uri);
      const expectedValue = false;
      expect(output, expectedValue);
    });
  });
}
