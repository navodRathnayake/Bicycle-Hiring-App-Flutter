library profile_completion_page;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/account_completion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileCompletion extends StatelessWidget {
  final ThemeData themeData;
  const ProfileCompletion({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCompletionBloc(),
      child: Builder(builder: (context) {
        return BlocBuilder<AccountCompletionBloc, AccountCompletionState>(
          builder: (context, state) {
            return Column(
              children: [
                Stepper(
                  type: StepperType.vertical,
                  currentStep: state.currentCompletionStep > 3
                      ? 0
                      : state.currentCompletionStep,
                  onStepTapped: (tappedIndex) {
                    BlocProvider.of<AccountCompletionBloc>(context)
                        .add(AccountCompletionStepEvent(
                      currentTappedStep: tappedIndex,
                      currentCompletionStep: state.currentCompletionStep,
                      progressIndicatorValue: state.progressIndicatorValue,
                    ));
                  },
                  steps: [
                    Step(
                      title: const Text('Create an account'),
                      content: state.currentCompletionStep > 3
                          ? Container()
                          : const Text(
                              'Create an account to log the system through your user name and strong password.'),
                      isActive: state.currentCompletionStep > 0,
                      state: state.currentCompletionStep > 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Verify the driving license'),
                      content: Column(
                        children: [
                          const Text(
                              'Verify your created user account trough Sri Lankan driving license for secure purpose.'),
                          const ColumnSpacer(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.all(8),
                                ),
                                onPressed: () {
                                  BlocProvider.of<AccountCompletionBloc>(
                                          context)
                                      .add(AccountCompletionStepEvent(
                                    currentTappedStep: state.currentTappedStep,
                                    currentCompletionStep:
                                        state.currentCompletionStep + 1,
                                    progressIndicatorValue:
                                        state.progressIndicatorValue + 25,
                                  ));
                                },
                                child: const FittedBox(
                                  child: Text('Enroll Now'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      isActive: state.currentCompletionStep > 1,
                      state: state.currentCompletionStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Pin Code intergration'),
                      content: Column(
                        children: [
                          const Text(
                              'Add a pin code for your creadit cards and secure them localy.'),
                          const ColumnSpacer(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.all(8),
                                ),
                                onPressed: () {
                                  BlocProvider.of<AccountCompletionBloc>(
                                          context)
                                      .add(AccountCompletionStepEvent(
                                    currentTappedStep: state.currentTappedStep,
                                    currentCompletionStep:
                                        state.currentCompletionStep + 1,
                                    progressIndicatorValue:
                                        state.progressIndicatorValue + 25,
                                  ));
                                },
                                child: const FittedBox(
                                  child: Text('Enroll Now'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      isActive: state.currentCompletionStep > 2,
                      state: state.currentCompletionStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Connect credit cards'),
                      content: Column(
                        children: [
                          const Text(
                              'Add your credit card to the app and save times at your transactions and make secure your transaction.'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.all(8),
                                ),
                                onPressed: () {
                                  BlocProvider.of<AccountCompletionBloc>(
                                          context)
                                      .add(AccountCompletionStepEvent(
                                    currentTappedStep: state.currentTappedStep,
                                    currentCompletionStep:
                                        state.currentCompletionStep + 1,
                                    progressIndicatorValue:
                                        state.progressIndicatorValue + 25,
                                  ));
                                },
                                child: const FittedBox(
                                  child: Text('Enroll Now'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      isActive: state.currentCompletionStep > 3,
                      state: state.currentCompletionStep > 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                  controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
                    return const Row(
                      children: <Widget>[],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 30.0,
                    animationDuration: 800,
                    percent: state.progressIndicatorValue / 100,
                    center: Text('${state.progressIndicatorValue.round()}%'),
                    progressColor: Colors.green,
                    barRadius: const Radius.circular(12),
                  ),
                ),
                const ColumnSpacer(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Why is this important?',
                        style: TextStyle(
                          color: themeData.colorScheme.onBackground,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const RowSpacer(width: 10),
                    Image.asset(
                      'Assets/icons/more_info.png',
                      scale: 2.8,
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Find out more detail on web | cycleLanka.org'),
                  ],
                ),
                const ColumnSpacer(height: 40),
              ],
            );
          },
        );
      }),
    );
  }
}
