import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SfSparkAreaChartSample extends StatefulWidget {
  @override
  _SfSparkAreaChartSampleState createState() => _SfSparkAreaChartSampleState();
}

class _SfSparkAreaChartSampleState extends State<SfSparkAreaChartSample> {
  List<ChartData> data = [
    ChartData(0, 1),
    ChartData(1, 1.5),
    ChartData(2, 1.4),
    ChartData(3, 3),
    ChartData(4, 2),
    ChartData(5, 2.2),
    ChartData(6, 1.8),
  ];

  @override
  Widget build(BuildContext context) {
    return SfSparkAreaChart();
  }
}

class ChartData {
  final double x;
  final double y;

  ChartData(this.x, this.y);
}
