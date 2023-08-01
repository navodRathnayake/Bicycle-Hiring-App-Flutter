library otp_body_loading_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OTPLoadingBodyPage extends StatefulWidget {
  const OTPLoadingBodyPage({super.key});

  @override
  State<OTPLoadingBodyPage> createState() => _OTPLoadingBodyPageState();
}

class _OTPLoadingBodyPageState extends State<OTPLoadingBodyPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColumnSpacer(height: 20),
              ShimmerCustomContainer(
                width: 100,
                height: 40,
                radius: 15,
              ),
              ColumnSpacer(height: 20),
              ShimmerCustomContainer(
                  width: double.maxFinite, height: 10, radius: 12),
              ColumnSpacer(height: 5),
              ShimmerCustomContainer(
                  width: double.maxFinite, height: 10, radius: 3),
              ColumnSpacer(height: 5),
              ShimmerCustomContainer(
                  width: double.maxFinite, height: 10, radius: 3),
              ColumnSpacer(height: 5),
              ShimmerCustomContainer(width: 50, height: 10, radius: 3),
              ColumnSpacer(height: 20),
              ShimmerCustomContainer(
                  width: double.maxFinite, height: 60, radius: 12),
              ColumnSpacer(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerCustomContainer(width: 50, height: 60, radius: 12),
                  Text('-'),
                  ShimmerCustomContainer(width: 50, height: 60, radius: 12),
                  Text('-'),
                  ShimmerCustomContainer(width: 50, height: 60, radius: 12),
                  Text('-'),
                  ShimmerCustomContainer(width: 50, height: 60, radius: 12),
                ],
              ),
              ColumnSpacer(height: 20),
              ShimmerCustomContainer(
                  width: double.maxFinite, height: 60, radius: 12),
              ColumnSpacer(height: 5),
              ShimmerCustomContainer(width: 100, height: 10, radius: 12),
              ColumnSpacer(height: 5),
              ShimmerCustomContainer(width: 50, height: 10, radius: 12),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShimmerCustomContainer(width: 100, height: 10, radius: 12),
              ColumnSpacer(height: 5),
              ShimmerCustomContainer(width: 120, height: 10, radius: 12),
              ColumnSpacer(height: 5),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerCustomContainer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  const ShimmerCustomContainer(
      {super.key, required this.width, required this.height, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: const Text('xss'),
      ),
    );
  }
}
