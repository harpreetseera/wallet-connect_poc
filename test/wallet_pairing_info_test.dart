import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:wallet_connect_poc/model/wc_pairing_info.dart';
import 'package:wallet_connect_poc/service_locator.dart';

void main() {
  group("tests wallet pairing info related tasks", () {
    test("Pairing test for a particular URI ", () async {
      SharedPreferences.setMockInitialValues({});
      await setupServiceLocator();
      const uri =
          "wc:15c0c3d75a3a47d58bc198161a150a08c64bc7b442f5dc700379c5ea2b762792@2?relay-protocol=irn&symKey=61cad7567663a45f188c0ee7fe99b7e8e8d8cccab095d776ea107dc7626451fb";
      final pairingInfo = WCInfo(uri: uri);
      await pairingInfo.pairConnection();
      const expectedTopicValue =
          "15c0c3d75a3a47d58bc198161a150a08c64bc7b442f5dc700379c5ea2b762792";
      expect(pairingInfo.pairingInfo!.topic, expectedTopicValue);
    });
  });
}
