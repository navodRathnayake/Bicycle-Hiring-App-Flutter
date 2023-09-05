part of 'ride_bloc.dart';

enum RideStatus { inProcess, success, failure }

enum LockStatus { inProcess, lock, unlock }

class RideState extends Equatable {
  final LockStatus lockStatus;
  final RideStatus status;
  final String msg;
  const RideState({
    this.status = RideStatus.inProcess,
    this.msg = 'Validating Payment',
    this.lockStatus = LockStatus.unlock,
  });

  RideState copyWith({
    RideStatus? status,
    String? msg,
    LockStatus? lockStatus,
  }) {
    return RideState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      lockStatus: lockStatus ?? this.lockStatus,
    );
  }

  @override
  List<Object?> get props => [status, msg, lockStatus];
}
