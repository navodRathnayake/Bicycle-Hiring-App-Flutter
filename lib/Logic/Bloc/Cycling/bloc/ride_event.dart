part of 'ride_bloc.dart';

class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object> get props => [];
}

class RideInitialEvent extends RideEvent {
  final User user;
  final Package package;

  const RideInitialEvent({required this.user, required this.package});

  @override
  List<Object> get props => [user, package];
}
