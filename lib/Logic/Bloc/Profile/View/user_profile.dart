library user_profile;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Profile/View/profile_info.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/dialogBox/transaction_dialog_box.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/recent_activity_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/transaction_chart_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/transaction_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/widget/dialogBox/pin_local_confirm_dialogBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/custom_list_tile.dart';
import 'widget/profile_activity_card.dart';
import 'widget/profile_avater.dart';

class UserProfile extends StatelessWidget {
  final ThemeData themeData;
  const UserProfile({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 0, top: 25, bottom: 10),
          child: Column(
            children: [
              ProfileAvater(themeData: themeData),
              const ColumnSpacer(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ProfileActivityCard(themeData: themeData),
              ),
              const ColumnSpacer(height: 10),
              // UserFunctionalityList(),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CustomListTile(
                          themeData: themeData,
                          url: 'Assets/icons/transaction.png',
                          title: 'View Transactions',
                          onTap: () {
                            transactionDialogBox(
                                context: context, themeData: themeData);
                            BlocProvider.of<TransactionBloc>(context)
                                .add(TransactionClickedEvent());
                            BlocProvider.of<TransactionChartBloc>(context)
                                .add(TransactionChartClickEvent());
                          }),
                      CustomListTile(
                        themeData: themeData,
                        url: 'Assets/icons/activities.png',
                        title: 'View Recent Activities',
                        onTap: () {
                          Navigator.of(context).pushNamed('/recentActivity');
                          BlocProvider.of<RecentActivityBloc>(context)
                              .add(RecentActivityClickedEvent());
                        },
                      ),
                      CustomListTile(
                        themeData: themeData,
                        url: 'Assets/icons/billing_details.png',
                        title: 'Billing Details',
                        onTap: () {
                          pinConfirmDialogBox(
                            context: context,
                            themeData: themeData,
                          );
                        },
                      ),
                      const Divider(),
                      CustomListTile(
                        themeData: themeData,
                        url: 'Assets/icons/information.png',
                        title: 'Information',
                        onTap: () {
                          profileInfoDialogBox(
                              context: context, themeData: themeData);
                        },
                      ),
                      CustomListTile(
                        themeData: themeData,
                        url: 'Assets/icons/carbon_foot_print.png',
                        title: 'Caarbon Foot Print',
                        onTap: () {
                          debugPrint('AAAA');
                          Navigator.of(context).pushNamed('/mapSample');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
