library custom_transaction_list_tile;

import 'package:flutter/material.dart';

class CustomTransactionListTile extends StatelessWidget {
  final ThemeData themeData;
  final int type;
  final String date;
  final double amount;
  const CustomTransactionListTile({
    super.key,
    required this.themeData,
    required this.type,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: themeData.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            type == 1
                ? 'Assets/icons/card_payment.png'
                : 'Assets/icons/transport_cost.png',
            scale: 2,
            color: themeData.colorScheme.onSecondaryContainer,
          ),
        ),
      ),
      title:
          type == 1 ? const Text('Card Payment') : const Text('Transport Cost'),
      subtitle: Text(date),
      trailing: const Text('Rs 2375'),
      tileColor: type == 1
          ? themeData.colorScheme.surfaceVariant
          : themeData.colorScheme.onInverseSurface,
      onTap: () {},
    );
  }
}
