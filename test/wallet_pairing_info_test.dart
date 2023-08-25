import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:wallet_connect_poc/model/wc_data.dart';

import 'package:wallet_connect_poc/service_locator.dart';

void main() {
  test("Tests for the topic while pairing with a particular URI ", () async {
    SharedPreferences.setMockInitialValues({});
    await setupServiceLocator();

    const uri =
        "wc:15c0c3d75a3a47d58bc198161a150a08c64bc7b442f5dc700379c5ea2b762792@2?relay-protocol=irn&symKey=61cad7567663a45f188c0ee7fe99b7e8e8d8cccab095d776ea107dc7626451fb";
    final wcData = WCData(uri: uri);
    await wcData.pairConnection();
    const expectedTopicValue =
        "15c0c3d75a3a47d58bc198161a150a08c64bc7b442f5dc700379c5ea2b762792";
    expect(wcData.pairingInfo!.topic, expectedTopicValue);
  });

  test("Tests for the relay protocol while pairing with a particular URI ",
      () async {
    SharedPreferences.setMockInitialValues({});
    await setupServiceLocator();
    const uri =
        "wc:15c0c3d75a3a47d58bc198161a150a08c64bc7b442f5dc700379c5ea2b762792@2?relay-protocol=irn&symKey=61cad7567663a45f188c0ee7fe99b7e8e8d8cccab095d776ea107dc7626451fb";
    final wcData = WCData(uri: uri);
    await wcData.pairConnection();
    const expectedRelayProtocolValue = "irn";
    expect(wcData.pairingInfo!.relay.protocol, expectedRelayProtocolValue);
  });
}
