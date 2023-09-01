import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final StepperBloc stepperInstance;
  RideBloc({required this.stepperInstance}) : super(const RideState()) {
    on<RideEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
