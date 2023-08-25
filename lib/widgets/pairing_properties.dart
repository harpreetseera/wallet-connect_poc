import 'package:flutter/material.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/model/wc_data.dart';
import 'package:wallet_connect_poc/service_locator.dart';
import 'package:wallet_connect_poc/size_config.dart';

class PairingProperties extends StatelessWidget {
  const PairingProperties({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final wcData = serviceLocator.get<WCData>();
    final pairingInfo = wcData.pairingInfo!;

    final propertiesMap = <String, String?>{
      AppData.uriText: wcData.uri,
      AppData.topicText: pairingInfo.topic,
      AppData.expiryText: pairingInfo.expiry.toString(),
      AppData.relayProtocolText: pairingInfo.relay.protocol,
      AppData.relayDataText: pairingInfo.relay.data,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: propertiesMap.entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.genricPaddingSize,
                vertical: SizeConfig.smallPaddingSize,
              ),
              child: SelectableText.rich(
                TextSpan(
                  text: "${entry.key} - ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: SizeConfig.customTextSize,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: entry.value,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
