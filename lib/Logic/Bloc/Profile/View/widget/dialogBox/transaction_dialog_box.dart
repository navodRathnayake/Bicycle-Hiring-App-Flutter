library transaction_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/charts/transaction_chart.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/custom_transaction_list_tile.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<void> transactionDialogBox(
    {required BuildContext context, required ThemeData themeData}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final controller = PageController(initialPage: 0);
      return BlocProvider(
        create: (context) => ProfileBloc(),
        child: AlertDialog(
          content: SingleChildScrollView(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.transactionDialogBoxStatus ==
                    TransactionDialogBox.listView) {
                  return TransactionListView(themeData: themeData);
                } else if (state.transactionDialogBoxStatus ==
                    TransactionDialogBox.chartView) {
                  return TransactionChartView(
                      themeData: themeData, controller: controller);
                } else if (state.transactionDialogBoxStatus ==
                    TransactionDialogBox.loading) {
                  return const CircularProgressIndicator();
                }
                throw Exception('Error : Unable to catch-up state');
              },
            ),
          ),
          actions: <Widget>[
            Builder(builder: (context) {
              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: state.transactionDialogBoxStatus ==
                                TransactionDialogBox.chartView
                            ? SmoothPageIndicator(
                                controller: controller,
                                count: 3,
                                effect: const WormEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    type: WormType.thin,
                                    activeDotColor: Colors.redAccent),
                              )
                            : null,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(ListViewEvent());
                                },
                                icon: Image.asset(
                                  'Assets/icons/list.png',
                                  scale: 3,
                                )),
                          ),
                          const RowSpacer(width: 10),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(ChartViewEvent());
                                },
                                icon: Image.asset(
                                  'Assets/icons/bar_chart.png',
                                  scale: 3,
                                )),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      );
    },
  );
}

class TransactionListView extends StatelessWidget {
  final ThemeData themeData;
  const TransactionListView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Account Transaction',
                style: themeData.textTheme.headlineSmall),
            DialogBoxCloseButton(themeData: themeData),
          ],
        ),
        const Divider(),
        const ColumnSpacer(height: 10),
        CustomTransactionListTile(
            themeData: themeData, type: 1, date: 'Jan-23-2023', amount: 2375),
        CustomTransactionListTile(
            themeData: themeData, type: 2, date: 'Jan-23-2023', amount: 2375),
        CustomTransactionListTile(
            themeData: themeData, type: 2, date: 'Jan-23-2023', amount: 2375),
        CustomTransactionListTile(
            themeData: themeData, type: 1, date: 'Jan-23-2023', amount: 2375),
      ],
    );
  }
}

class TransactionChartView extends StatelessWidget {
  final ThemeData themeData;
  final PageController controller;
  const TransactionChartView(
      {super.key, required this.themeData, required this.controller});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      TransactionChart(themeData: themeData),
      TransactionChart(themeData: themeData),
      TransactionChart(themeData: themeData),
    ];
    return ListBody(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Account Transaction',
                style: themeData.textTheme.headlineSmall),
            DialogBoxCloseButton(themeData: themeData),
          ],
        ),
        const Divider(),
        SizedBox(
          height: 300,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView.builder(
              itemCount: pages.length,
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: pages[index],
                );
              },
            ),
          ),
        ),
        const ColumnSpacer(height: 10),
        const Text(
            'A bar chart is a type of chart that presents categorical data with rectangular bars with heights or lengths proportional to the values that they represent. Bar charts are used to compare different categories or discrete data and are useful for identifying possible relationships between them.'),
        const ColumnSpacer(height: 10),
      ],
    );
  }
}
