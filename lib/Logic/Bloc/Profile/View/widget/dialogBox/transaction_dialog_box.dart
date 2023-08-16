library transaction_dialog_box;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/src/dialogBox/dialogbox_close_button.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/charts/transaction_chart.dart';
import 'package:final_project/Logic/Bloc/Profile/View/widget/custom_transaction_list_tile.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/profile_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/transaction_chart_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/transaction_bloc.dart';
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
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state.status == TransactionStatus.inProcess) {
          return TransactionInprocess(themeData: themeData);
        } else if (state.status == TransactionStatus.success) {
          return TransactionSuccess(themeData: themeData);
        } else if (state.status == TransactionStatus.failure) {
          return TransactionFailure(themeData: themeData);
        } else {
          return Container();
        }
      },
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
    return BlocBuilder<TransactionChartBloc, TransactionChartState>(
      builder: (context, state) {
        if (state.status == TransactionChartStatus.inProcess) {
          return TransactionChartInprocess(themeData: themeData);
        } else if (state.status == TransactionChartStatus.success) {
          return TransactionChartSuccess(
              themeData: themeData, controller: controller, pages: pages);
        } else if (state.status == TransactionChartStatus.failure) {
          return TransactionChartFailure(themeData: themeData);
        } else {
          return Container();
        }
      },
    );
  }
}

class TransactionSuccess extends StatelessWidget {
  final ThemeData themeData;
  const TransactionSuccess({super.key, required this.themeData});

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
        // CustomTransactionListTile(
        //     themeData: themeData, type: 1, date: 'Jan-23-2023', amount: 2375),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return Container(
              width: 100,
              height: 300,
              child: ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) => CustomTransactionListTile(
                  themeData: themeData,
                  type: state.transactions[index]['transactionStatus']['id'],
                  date: state.transactions[index]['createdAt'],
                  amount: double.parse(state.transactions[index]['amount']),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class TransactionInprocess extends StatelessWidget {
  final ThemeData themeData;
  const TransactionInprocess({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DialogBoxCloseButton(themeData: themeData),
          ],
        ),
        const ColumnSpacer(height: 30),
        const CircularProgressIndicator(),
        const ColumnSpacer(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text('Adding Creadit',
              style: TextStyle(
                fontSize: 25,
              )),
        ),
        const ColumnSpacer(height: 5),
        const Text('Card',
            style: TextStyle(
              fontSize: 25,
            )),
        const ColumnSpacer(height: 10),
        const Text('It will take a while')
      ],
    );
  }
}

class TransactionFailure extends StatelessWidget {
  final ThemeData themeData;
  const TransactionFailure({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialogBoxCloseButton(themeData: themeData),
              ],
            ),
            const ColumnSpacer(height: 10),
            Image.asset('Assets/icons/sad.png',
                color: themeData.colorScheme.onBackground),
            const ColumnSpacer(height: 10),
            const Text('Something',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 5),
            const Text('Went Wrong',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 5),
            const Text('Buddy!',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Try again to fill your account with points',
                textAlign: TextAlign.center,
              ),
            ),
            const ColumnSpacer(height: 30),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<TransactionBloc>(context)
                    .add(TransactionClickedEvent());
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionChartSuccess extends StatelessWidget {
  final List<Widget> pages;
  final ThemeData themeData;
  final PageController controller;
  const TransactionChartSuccess(
      {super.key,
      required this.themeData,
      required this.controller,
      required this.pages});

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

class TransactionChartInprocess extends StatelessWidget {
  final ThemeData themeData;
  const TransactionChartInprocess({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DialogBoxCloseButton(themeData: themeData),
          ],
        ),
        const ColumnSpacer(height: 30),
        const CircularProgressIndicator(),
        const ColumnSpacer(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text('Adding Creadit',
              style: TextStyle(
                fontSize: 25,
              )),
        ),
        const ColumnSpacer(height: 5),
        const Text('Card',
            style: TextStyle(
              fontSize: 25,
            )),
        const ColumnSpacer(height: 10),
        const Text('It will take a while')
      ],
    );
  }
}

class TransactionChartFailure extends StatelessWidget {
  final ThemeData themeData;
  const TransactionChartFailure({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialogBoxCloseButton(themeData: themeData),
              ],
            ),
            const ColumnSpacer(height: 10),
            Image.asset('Assets/icons/sad.png',
                color: themeData.colorScheme.onBackground),
            const ColumnSpacer(height: 10),
            const Text('Something',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 5),
            const Text('Went Wrong',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 5),
            const Text('Buddy!',
                style: TextStyle(
                  fontSize: 25,
                )),
            const ColumnSpacer(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Try again to fill your account with points',
                textAlign: TextAlign.center,
              ),
            ),
            const ColumnSpacer(height: 30),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<TransactionChartBloc>(context)
                    .add(TransactionChartClickEvent());
              },
              child: const Text('Try Again'),
            )
          ],
        ),
      ),
    );
  }
}
