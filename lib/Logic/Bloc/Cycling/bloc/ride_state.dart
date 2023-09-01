part of 'ride_bloc.dart';

enum RideStatus { inProcess, success, failure }

class RideState extends Equatable {
  final RideStatus status;
  final String msg;
  const RideState({
    this.status = RideStatus.inProcess,
    this.msg = '',
  });

  RideState copyWith({
    RideStatus? status,
    String? msg,
  }) {
    return RideState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props => [status, msg];
}
