part of 'cycling_bloc.dart';

abstract class CyclingState extends Equatable {
  const CyclingState();
  
  @override
  List<Object> get props => [];
}

class CyclingInitial extends CyclingState {}
