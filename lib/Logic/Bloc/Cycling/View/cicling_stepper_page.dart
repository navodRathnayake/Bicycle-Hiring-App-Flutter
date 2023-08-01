library cycling_stepper_page;

import 'package:final_project/Logic/Bloc/Cycling/View/steps/bicycle_data_view.dart';
import 'package:final_project/Logic/Bloc/Cycling/View/steps/bicycle_package_view.dart';
import 'package:final_project/Logic/Bloc/Cycling/View/steps/bicycle_term_and_condition_view.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/avatar.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/custom_settings_icon.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/points.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/popup_settings_menu.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CyclingStepperPage extends StatelessWidget {
  final ThemeData themeData;
  const CyclingStepperPage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StepperBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Image.asset(
                    'Assets/icons/back_arrow.png',
                    scale: 2,
                    color: themeData.colorScheme.onBackground,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Points(themeData: themeData),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Avatar(),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: PopUpSettingsMenu(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                    icon: CustomSettingsIcon(
                      themeData: themeData,
                    ))),
          ],
        ),
        body: BlocBuilder<StepperBloc, StepperState>(
          builder: (context, state) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: state.currentStep - 1,
              onStepTapped: (tappedIndex) {
                BlocProvider.of<StepperBloc>(context)
                    .add(CycleStepperChanged(currentStep: tappedIndex));
              },
              steps: [
                Step(
                  title: const Text('Bicycle'),
                  content: BicycleDataView(themeData: themeData),
                  isActive: state.currentStep > 0,
                  state: state.currentStep > 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Package'),
                  content: BicyclePackageView(themeData: themeData),
                  isActive: state.currentStep > 1,
                  state: state.currentStep > 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Terms'),
                  content: BicycleTermAndConditionView(themeData: themeData),
                  isActive: state.currentStep > 2,
                  state: state.currentStep > 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
              controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
                return Row(
                  children: <Widget>[
                    TextButton(
                      onPressed: dtl.onStepContinue,
                      child: const Text(''),
                    ),
                    TextButton(
                      onPressed: dtl.onStepCancel,
                      child: const Text(''),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
