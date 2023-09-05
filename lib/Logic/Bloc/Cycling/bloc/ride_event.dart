part of 'ride_bloc.dart';

class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object> get props => [];
}

class RideInitialEvent extends RideEvent {
  final User user;
  final Package package;
  final Bicycle bicycle;

  const RideInitialEvent(
      {required this.user, required this.package, required this.bicycle});

  @override
  List<Object> get props => [user, package, bicycle];
}

class RideLockPressedEvent extends RideEvent {
  final Bicycle bicycle;
  const RideLockPressedEvent({required this.bicycle});

  @override
  List<Object> get props => [bicycle];
}

class RideMapLauncherOnPressed extends RideEvent {}

class RideMapRollBackOnPressed extends RideEvent {}
