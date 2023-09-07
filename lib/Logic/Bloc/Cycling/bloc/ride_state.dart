part of 'ride_bloc.dart';

enum RideStatus { inProcess, success, map, failure }

enum LockStatus { inProcess, lock, unlock }

enum CompleteStatus { initial, success, failure }

class RideState extends Equatable {
  final LockStatus lockStatus;
  final CompleteStatus completeStatus;
  final RideStatus status;
  final String msg;
  final String pathID;
  final String startLang;
  final String startLong;
  final String startLocation;
  final String endLocation;
  final String endLang;
  final String endLong;

  const RideState({
    this.status = RideStatus.inProcess,
    this.msg = 'Validating Payment',
    this.lockStatus = LockStatus.unlock,
    this.completeStatus = CompleteStatus.initial,
    this.pathID = '',
    this.startLang = '',
    this.startLong = '',
    this.startLocation = '',
    this.endLang = '',
    this.endLong = '',
    this.endLocation = '',
  });

  RideState copyWith({
    RideStatus? status,
    String? msg,
    LockStatus? lockStatus,
    CompleteStatus? completeStatus,
    String? pathID,
    String? startLang,
    String? startLong,
    String? startLocation,
    String? endLang,
    String? endLong,
    String? endLocation,
  }) {
    return RideState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      lockStatus: lockStatus ?? this.lockStatus,
      completeStatus: completeStatus ?? this.completeStatus,
      pathID: pathID ?? this.pathID,
      startLang: startLang ?? this.startLang,
      startLong: startLong ?? this.startLong,
      startLocation: startLocation ?? this.startLocation,
      endLang: endLang ?? this.endLang,
      endLong: endLong ?? this.endLong,
      endLocation: endLocation ?? this.endLocation,
    );
  }

  @override
  List<Object?> get props => [
        status,
        msg,
        lockStatus,
        completeStatus,
        pathID,
        startLang,
        startLong,
        startLocation,
        endLang,
        endLong,
        endLocation,
      ];
}
