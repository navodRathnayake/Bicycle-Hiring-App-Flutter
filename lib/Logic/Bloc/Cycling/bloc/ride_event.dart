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

class RideMapLauncherOnPressedEvent extends RideEvent {}

class RideMapRollBackOnPressedEvent extends RideEvent {}

class RideCompleteOnPressedEvent extends RideEvent {
  final User user;
  final String date;
  final Package package;
  final Bicycle bicycle;
  const RideCompleteOnPressedEvent(
      {required this.date,
      required this.package,
      required this.user,
      required this.bicycle});

  @override
  List<Object> get props => [date, package, user, bicycle];
}

class RideStartLocationDataEvent extends RideEvent {
  final String startLang;
  final String startLong;
  final String startLocation;

  const RideStartLocationDataEvent(
      {required this.startLang,
      required this.startLong,
      required this.startLocation});

  @override
  List<Object> get props => [startLang, startLong, startLocation];
}

class RideEndLocationDataEvent extends RideEvent {
  final String endLang;
  final String endLong;
  final String endLocation;

  const RideEndLocationDataEvent(
      {required this.endLang,
      required this.endLong,
      required this.endLocation});

  @override
  List<Object> get props => [endLang, endLong, endLocation];
}
