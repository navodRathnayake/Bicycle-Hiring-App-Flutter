library radial_chart;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialChart extends StatelessWidget {
  const RadialChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries>[
        // Renders radial bar chart
        RadialBarSeries<UserTransaction, String>(
            dataSource: chartData,
            // dataLabelSettings: DataLabelSettings(
            //   isVisible: false,
            // ),
            xValueMapper: (UserTransaction data, _) => data.dateTime,
            yValueMapper: (UserTransaction data, _) => data.amount),
      ],
    );
  }
}

List<UserTransaction> chartData = const [
  UserTransaction(dateTime: 'jan 23', amount: 200.12),
  UserTransaction(dateTime: 'feb 04', amount: 106.18),
  UserTransaction(dateTime: 'march 14', amount: 78.23),
  UserTransaction(dateTime: 'April 20', amount: 521.45),
  UserTransaction(dateTime: 'may 03', amount: 65.01),
];

class UserTransaction {
  final String dateTime;
  final double amount;
  const UserTransaction({required this.dateTime, required this.amount});
}
