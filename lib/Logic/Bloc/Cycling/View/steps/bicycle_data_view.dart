library bicycle_data_view;

import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BicycleDataView extends StatelessWidget {
  final ThemeData themeData;
  const BicycleDataView({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<StepperBloc, StepperState>(
        builder: (context, state) {
          return Column(
            children: [
              const ColumnSpacer(height: 10),
              Stack(
                children: [
                  const Positioned(
                    right: -50,
                    child: CircleAvatar(
                      radius: 170,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  const Positioned(
                    left: 10,
                    bottom: 20,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  const Positioned(
                    left: 30,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 40, right: 20, bottom: 90),
                    child: Image.asset('Assets/icons/bicycle_sharing.png'),
                  ),
                ],
              ),
              const ColumnSpacer(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VEHICLE MAX HIEGHT',
                          style: themeData.textTheme.bodyLarge,
                        ),
                        const ColumnSpacer(height: 5),
                        Text(
                          '${state.bicycle.height.toString()} - 150 cm',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BIKE WEIGHT',
                          style: themeData.textTheme.bodyLarge,
                        ),
                        const ColumnSpacer(height: 5),
                        Text('${state.bicycle.weight.toString()} kg',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              const ColumnSpacer(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SERVICE STATION',
                          style: themeData.textTheme.bodyLarge,
                        ),
                        const ColumnSpacer(height: 5),
                        Text(
                          state.bicycle.station.toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BIKE MANUF:',
                          style: themeData.textTheme.bodyLarge,
                        ),
                        const ColumnSpacer(height: 5),
                        Text(
                          state.bicycle.manufacturedDate.toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const ColumnSpacer(height: 10),
              const Text(
                'This bicycle sharing rental sysytem is implemented as a transportation model for Sri Lanka.',
                textAlign: TextAlign.center,
              ),
              const ColumnSpacer(height: 10),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<StepperBloc>(context)
                      .add(const CycleStepperChanged(currentStep: 1));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.only(top: 8, right: 15, bottom: 8, left: 16),
                    child: Text('RENT A BICYCLE',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
