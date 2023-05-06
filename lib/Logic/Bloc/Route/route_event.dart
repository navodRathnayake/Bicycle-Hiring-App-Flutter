part of 'route_bloc.dart';

@immutable
abstract class RouteEvent extends Equatable {
  const RouteEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class _RouteChangeEvent extends RouteEvent {
  final RouteStatus status;
  const _RouteChangeEvent({required this.status});
}
