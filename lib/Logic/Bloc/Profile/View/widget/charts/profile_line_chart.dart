library profile_line_chart;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ProfileLineChart extends StatelessWidget {
  const ProfileLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfSparkLineChart(
        //Enable the trackball
        trackball:
            SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
        //Enable marker
        marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
        axisCrossesAt: 1,
        axisLineDashArray: [2, 2],
        dashArray: [2, 2],
        plotBand: SparkChartPlotBand(),

        //Enable data label
        labelDisplayMode: SparkChartLabelDisplayMode.none,
        axisLineColor: Colors.red,
        data: <double>[
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
