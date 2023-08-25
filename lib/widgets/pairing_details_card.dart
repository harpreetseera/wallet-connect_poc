import 'package:flutter/material.dart';
import 'package:wallet_connect_poc/model/wc_data.dart';
import 'package:wallet_connect_poc/service_locator.dart';
import 'package:wallet_connect_poc/widgets/pairing_properties.dart';

class PairingDetailsCard extends StatelessWidget {
  const PairingDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final wcData = serviceLocator.get<WCData>();
    return Column(
      children: <Widget>[
        Card(
          margin: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  "Pairing Details",
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
              ),
              PairingProperties(
                property: "Uri",
                value: wcData.uri,
              ),
              PairingProperties(
                property: "Topic",
                value: wcData.pairingInfo!.topic,
              ),
              PairingProperties(
                property: "Expiry",
                value: wcData.pairingInfo!.expiry.toString(),
              ),
              PairingProperties(
                property: "Relay Protocol",
                value: wcData.pairingInfo!.relay.protocol,
              ),
              PairingProperties(
                property: "Relay Data",
                value: wcData.pairingInfo!.relay.data,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
