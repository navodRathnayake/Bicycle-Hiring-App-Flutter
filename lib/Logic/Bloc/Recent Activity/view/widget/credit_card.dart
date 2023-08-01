library credit_card;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final String cardType;
  final String cardNumber;
  final String cardHolder;
  final bool isMaster;
  final ThemeData themeData;
  const CreditCard({
    super.key,
    required this.themeData,
    required this.cardType,
    required this.cardNumber,
    required this.cardHolder,
    required this.isMaster,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  const ColumnSpacer(height: 25),
                  Image.asset(
                    'Assets/icons/world.png',
                    color: Colors.grey,
                  ),
                ],
              ),
              CardInfo(themeData: themeData),
            ],
          ),
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  final ThemeData themeData;
  const CardInfo({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('CREDIT CARD', style: themeData.textTheme.headlineMedium),
          ],
        ),
        const ColumnSpacer(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'Assets/icons/chip.png',
              scale: 1,
            ),
          ],
        ),
        const ColumnSpacer(height: 10),
        Row(
          children: [
            Text(
              '1234-5678-XXXX-2345',
              style: themeData.textTheme.headlineMedium,
            ),
          ],
        ),
        Row(
          children: [
            Text('CARD HOLDER NAME', style: themeData.textTheme.headlineSmall),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'Assets/icons/master_card.png',
              scale: 80,
            )
          ],
        ),
      ],
    );
  }
}
