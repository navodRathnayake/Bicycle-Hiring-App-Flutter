import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Cycling/model/bicycle_model.dart';
import 'package:flutter/foundation.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  StepperBloc() : super(const StepperState.step1()) {
    on<CycleStepperChanged>(_onStepperChanged);
    on<BicycleInfoPassEvent>(_onBicycleInfoPass);
    on<PackageOnChangedEvent>(_onPackageChanged);
    on<StepperRollBackEvent>(_stepperRollBack);
    on<StepperAcceptEvent>(_onStepperAccept);
  }

  Future<void> _onStepperChanged(
    CycleStepperChanged event,
    Emitter<StepperState> emit,
  ) async {
    switch (event.currentStep) {
      case 0:
        emit(state.copyWith(currentStep: 1));
        break;
      case 1:
        emit(state.copyWith(currentStep: 2));
        break;

      case 2:
        emit(state.copyWith(currentStep: 3));
        break;

      default:
        emit(state.copyWith(currentStep: 1));
        break;
    }
  }

  Future<void> _onBicycleInfoPass(
    BicycleInfoPassEvent event,
    Emitter<StepperState> emit,
  ) async {
    emit(state.copyWith(
      bicycle: event.bicycle,
    ));
    debugPrint('Bicycle State Has Updated!');
  }

  Future<void> _onPackageChanged(
    PackageOnChangedEvent event,
    Emitter<StepperState> emit,
  ) async {
    switch (event.index) {
      case 0:
        emit(state.copyWith(package: Package.min30));
        debugPrint('SELECTED PACKAGE : min30');
        break;
      case 1:
        emit(state.copyWith(package: Package.min60));
        debugPrint('SELECTED PACKAGE : min60');
        break;
      case 2:
        emit(state.copyWith(package: Package.min120));
        debugPrint('SELECTED PACKAGE : min120');
        break;
      case 3:
        emit(state.copyWith(package: Package.hour5));
        debugPrint('SELECTED PACKAGE : hour5');
        break;
      default:
        emit(state.copyWith(package: Package.min120));
        debugPrint('SELECTED PACKAGE : min120');
    }
  }

  Future<void> _stepperRollBack(
    StepperRollBackEvent event,
    Emitter<StepperState> emit,
  ) async {
    emit(const StepperState.rollback());
  }

  Future<void> _onStepperAccept(
    StepperAcceptEvent event,
    Emitter<StepperState> emit,
  ) async {}
}
