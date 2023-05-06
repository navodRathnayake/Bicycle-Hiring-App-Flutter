part of 'network_cubit.dart';

enum NetworkStatus { mobile, wifi, none }

@immutable
abstract class NetworkState {}

class NetworkLoading extends NetworkState {}

class NetworkConnected extends NetworkState {
  final NetworkStatus status;
  NetworkConnected({required this.status});
}

class NetworkDisconnected extends NetworkState {
  final NetworkStatus status;
  NetworkDisconnected({required this.status});
}
