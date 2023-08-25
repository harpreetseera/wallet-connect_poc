import 'package:flutter/material.dart';
import 'package:wallet_connect_poc/app_data.dart';
import 'package:wallet_connect_poc/size_config.dart';
import 'package:wallet_connect_poc/widgets/pairing_properties.dart';

class PairingDetailsCard extends StatelessWidget {
  const PairingDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerColor =
        Theme.of(context).colorScheme.tertiary.withOpacity(0.1);
    final pairingDetailTitleStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Theme.of(context).colorScheme.tertiary);

    return Column(
      children: <Widget>[
        Card(
          margin: const EdgeInsets.all(SizeConfig.genricPaddingSize),
          color: Theme.of(context).colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SizeConfig.genricPaddingSize,
                  SizeConfig.genricPaddingSize,
                  SizeConfig.genricPaddingSize,
                  0,
                ),
                child: Text(
                  AppData.pairingDetailsText,
                  style: pairingDetailTitleStyle,
                ),
              ),
              Divider(
                color: dividerColor,
              ),
              const PairingProperties()
            ],
          ),
        ),
      ],
    );
  }
}
