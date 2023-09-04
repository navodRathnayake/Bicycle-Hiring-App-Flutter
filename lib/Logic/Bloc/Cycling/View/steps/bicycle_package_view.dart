library bicycle_package_view;

import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Constraints/constraints.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/cycling_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BicyclePackageView extends StatelessWidget {
  final ThemeData themeData;
  const BicyclePackageView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CyclingBloc(),
      child: Stack(
        children: [
          const Column(
            children: [
              CircleAvatar(
                radius: 0,
                backgroundColor: Colors.amber,
              ),
            ],
          ),
          PackageBody(themeData: themeData),
        ],
      ),
    );
  }
}

class PackageBody extends StatelessWidget {
  final ThemeData themeData;
  const PackageBody({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Sellect Your Package',
                  style: TextStyle(
                    color: themeData.colorScheme.onBackground,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                'Chose your desired plan to get access to your bike. Share it! Enjoy it!',
                textAlign: TextAlign.center,
                style: TextStyle(color: themeData.colorScheme.onBackground),
              ),
              const ColumnSpacer(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: packages.length,
                itemBuilder: (context, index) => PackageSelection(
                  themeData: themeData,
                  type: packages[index][0],
                  package: packages[index][1],
                  cost: packages[index][2],
                  index: index,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const ColumnSpacer(height: 10),
              const Text(
                'This is the sample text and need to add some instruction here.',
                textAlign: TextAlign.center,
              ),
              const ColumnSpacer(height: 10),
              Center(
                  child: GestureDetector(
                onTap: () {
                  debugPrint(
                      'CURRENT PACKAGE BTN : ${BlocProvider.of<StepperBloc>(context).state.package}');
                  BlocProvider.of<StepperBloc>(context)
                      .add(const CycleStepperChanged(currentStep: 2));
                  debugPrint(
                      'AFTER PACKAGE BTN : ${BlocProvider.of<StepperBloc>(context).state.package}');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Tap to Confirm Selection',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class PackageSelection extends StatelessWidget {
  final String package;
  final String cost;
  final String type;
  final int index;
  final ThemeData themeData;
  const PackageSelection({
    super.key,
    required this.themeData,
    required this.package,
    required this.cost,
    required this.type,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CyclingBloc, CyclingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<CyclingBloc>(context)
                  .add(CyclePackagePressEvent(index: index));
              BlocProvider.of<StepperBloc>(context)
                  .add(PackageOnChangedEvent(index: index));
            },
            child: Container(
              decoration: BoxDecoration(
                border: state.currentPackage == packages[index][3]
                    ? Border.all(color: Colors.blue.shade200, width: 5)
                    : null,
                color: themeData.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<CyclingBloc, CyclingState>(
                    builder: (context, state) {
                      if (state.currentPackage == packages[index][3]) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: Text('',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    )),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          package,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cost,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
