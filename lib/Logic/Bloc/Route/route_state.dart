part of 'route_bloc.dart';

class RouteState extends Equatable {
  final RouteStatus status;

  const RouteState._({
    this.status = RouteStatus.initial,
  });

  const RouteState.initial() : this._();
  const RouteState.engage() : this._(status: RouteStatus.engage);

  @override
  List<Object?> get props => [status];
}
