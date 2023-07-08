library transaction_chart;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TransactionChart extends StatelessWidget {
  final ThemeData themeData;
  const TransactionChart({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    List<TransactionData> cardPayment = const [
      TransactionData(day: 'M', amount: 200.75),
      TransactionData(day: 'T', amount: 100.75),
      TransactionData(day: 'W', amount: 50.75),
      TransactionData(day: 'F', amount: 320.75),
      TransactionData(day: 'S', amount: 53.75),
      TransactionData(day: 'SE', amount: 32.75),
    ];
    List<TransactionData> ridePayment = const [
      TransactionData(day: 'M', amount: 100.75),
      TransactionData(day: 'T', amount: 200.75),
      TransactionData(day: 'W', amount: 30.75),
      TransactionData(day: 'F', amount: 220.75),
      TransactionData(day: 'S', amount: 153.75),
      TransactionData(day: 'SE', amount: 72.75),
    ];
    return Container(
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          legend: Legend(isVisible: true),
          // primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
          series: <ChartSeries<TransactionData, String>>[
            ColumnSeries<TransactionData, String>(
                dataSource: cardPayment,
                xValueMapper: (TransactionData data, _) => data.day,
                yValueMapper: (TransactionData data, _) => data.amount,
                name: 'Card',
                color: const Color.fromRGBO(8, 142, 255, 1)),
            ColumnSeries<TransactionData, String>(
                dataSource: ridePayment,
                xValueMapper: (TransactionData data, _) => data.day,
                yValueMapper: (TransactionData data, _) => data.amount,
                name: 'Ride',
                color: const Color.fromRGBO(5, 35, 59, 1))
          ],
        ),
      ),
    );
  }
}

class TransactionData {
  final String day;
  final double amount;

  const TransactionData({required this.day, required this.amount});
}
