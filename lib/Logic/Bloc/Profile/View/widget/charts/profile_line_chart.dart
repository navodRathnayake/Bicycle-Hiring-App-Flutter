library profile_line_chart;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ProfileLineChart extends StatelessWidget {
  const ProfileLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfSparkLineChart(
        //Enable the trackball
        trackball: const SparkChartTrackball(
            activationMode: SparkChartActivationMode.tap),
        //Enable marker
        marker: const SparkChartMarker(
            displayMode: SparkChartMarkerDisplayMode.all),
        axisCrossesAt: 1,
        axisLineDashArray: const [2, 2],
        dashArray: const [2, 2],
        plotBand: const SparkChartPlotBand(),

        //Enable data label
        labelDisplayMode: SparkChartLabelDisplayMode.none,
        axisLineColor: Colors.red,
        data: const <double>[
          1,
          5,
          -6,
          0,
          1,
          -2,
          7,
          -7,
          -4,
          -10,
          13,
          -6,
          7,
          5,
          11,
          5,
          3
        ]);
  }
}
