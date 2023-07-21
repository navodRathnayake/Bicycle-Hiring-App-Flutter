part of 'cycling_bloc.dart';

abstract class CyclingEvent extends Equatable {
  const CyclingEvent();

  @override
  List<Object> get props => [];
}

class CyclePackagePressEvent extends CyclingEvent {
  final int index;
  const CyclePackagePressEvent({required this.index});
}
