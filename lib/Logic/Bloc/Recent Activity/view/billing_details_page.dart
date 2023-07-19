library billing_details_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/custom_list_tile.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/credit_card.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/dialogBox/add_new_credit_card.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/recent_activity_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class BillingDetailsPage extends StatelessWidget {
  final ThemeData themeData;
  const BillingDetailsPage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 0, top: 25, bottom: 10),
            child: RecentActivityAppBar(
              title: 'Billing Details',
              themeData: themeData,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Container(
              width: double.maxFinite,
              height: 500,
              child: Swiper(
                loop: true,
                duration: 1200,
                itemCount: 3,
                itemWidth: double.maxFinite,
                itemHeight: 270,
                scrollDirection: Axis.vertical,
                layout: SwiperLayout.STACK,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: CreditCard(
                    themeData: themeData,
                    cardType: 'CREDIT CARD',
                    cardNumber: '1234-5678-XXXX-9101-2345',
                    cardHolder: 'CARD HOLDER',
                    isMaster: true,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured',
                    style: themeData.textTheme.headlineSmall,
                  ),
                  const ColumnSpacer(height: 10),
                  CustomListTile(
                    themeData: themeData,
                    title: 'Add New Credit Card',
                    url: 'Assets/icons/card_payment.png',
                    onTap: () {
                      addNewCreditCardDialogBox(
                          context: context, themeData: themeData);
                    },
                  ),
                  const ColumnSpacer(height: 10),
                  CustomListTile(
                    themeData: themeData,
                    title: 'Add Creadits to Account',
                    url: 'Assets/icons/deposit.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
