library billing_details_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogBox_ok_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_secondary_button.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/custom_list_tile.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/add_creadit_form_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/credit_card.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/dialogBox/add_credits_to_account.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/dialogBox/add_new_credit_card.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/recent_activity_app_bar.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class BillingDetailsPage extends StatelessWidget {
  final ThemeData themeData;
  final AuthenticationRepository authenticationRepository;
  const BillingDetailsPage(
      {super.key,
      required this.themeData,
      required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: SizedBox(
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
                    onTap: () async {
                      BlocProvider.of<AddCreaditFormBloc>(context)
                          .add(AddCreaditFormClearEvent());
                      debugPrint(authenticationRepository.status.toString());
                      var res = await authenticationRepository
                          .getCurrentAuthenticationStatus();
                      if (res == AuthenticationStatus.loginNonVerified) {
                        needVerifiedAccount(
                          context: context,
                          themeData: themeData,
                        );
                      } else if (res == AuthenticationStatus.logingVerified) {
                        final List<String> cardNumbers =
                            await SqfliteHelper.instance.readCardNumbers();
                        addCreaditToAccount(
                          context: context,
                          themeData: themeData,
                          cardNumbers: cardNumbers,
                        );
                      }
                    },
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

Future<void> needVerifiedAccount({
  required BuildContext context,
  required ThemeData themeData,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('Assets/icons/sad.png',
                        color: themeData.colorScheme.onBackground),
                    const ColumnSpacer(height: 10),
                    const Text('Cant Access',
                        style: TextStyle(
                          fontSize: 25,
                        )),
                    const ColumnSpacer(height: 5),
                    const Text('Without Verified',
                        style: TextStyle(
                          fontSize: 25,
                        )),
                    const ColumnSpacer(height: 5),
                    const Text('Buddy!',
                        style: TextStyle(
                          fontSize: 25,
                        )),
                    const ColumnSpacer(height: 10),
                    const Text(
                      'Try to be verified to function this',
                      textAlign: TextAlign.center,
                    ),
                    const ColumnSpacer(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Try Again'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          DialogBoxSecondaryButton(
              themeData: themeData,
              label: 'No,later',
              onTap: Navigator.of(context).pop),
          DialogBoxOkButton(
              label: 'Ok, Got it!', onTap: Navigator.of(context).pop),
        ],
      );
    },
  );
}
