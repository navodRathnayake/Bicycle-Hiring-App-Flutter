import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/stepper_bloc.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/data%20provider/validate_bicycle_api.dart';
import 'package:final_project/Logic/Bloc/Cycling/data/repository%20provider/validate_bicycle_repository.dart';
import 'package:final_project/Logic/Bloc/Cycling/model/bicycle_model.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

part 'qr_scan_event.dart';
part 'qr_scan_state.dart';

class QRScanBloc extends Bloc<QRScanEvent, QRScanState> {
  final StepperBloc stepperBloc;
  final AuthenticationRepository authenticationRepository;
  QRScanBloc(
      {required this.stepperBloc, required this.authenticationRepository})
      : super(const QRScanState()) {
    on<QRScanOnDetectEvent>(_onQRScanOnDetect);
    on<QRScanTryAgainEvent>(_onQRScanTryAgain);
    on<QRScanRollBackEvent>(_onQRScanRollBack);
  }

  Future<void> _onQRScanOnDetect(
    QRScanOnDetectEvent event,
    Emitter<QRScanState> emit,
  ) async {
    emit(state.copyWith(
      status: QRScanStatus.inProcess,
      displayValue: event.displayValue,
    ));

    debugPrint(state.displayValue.toString());

    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      if (state.displayValue.contains(RegExp(r'^\d+$'))) {
        emit(state.copyWith(
          displayValue: int.parse(state.displayValue).toString(),
          inProcessMsg: 'Validating the Relevent Bicycle',
        ));

        var response = await ValidateBicycleRepository(
          bicycleID: state.displayValue,
          api: ValidateBicycleApi(),
        ).getBicycleResponse();

        debugPrint(response.toString());
        debugPrint(response['body']['Bicycle'].toString());
        debugPrint(response['body']['Bicycle']['statusId'].toString());
        debugPrint(
            'ID : ${response['body']['Bicycle']['statusId']['id'].toString()}');

        if (response['body']['Bicycle']['statusId']['id'].toString() == '1') {
          emit(state.copyWith(
            status: QRScanStatus.success,
          ));

          Bicycle bicycle = Bicycle(
            bicycleID: response['body']['Bicycle']['bicycleId'].toString(),
            bicycleType:
                response['body']['Bicycle']['typeId']['type'].toString(),
            height: response['body']['Bicycle']['height'].toString(),
            weight: response['body']['Bicycle']['weight'].toString(),
            station: response['body']['Bicycle']['station']['name'].toString(),
            manufacturedDate:
                response['body']['Bicycle']['manufactured'].toString(),
          );

          debugPrint(bicycle.toString());

          stepperBloc.add(BicycleInfoPassEvent(bicycle: bicycle));
          // bicycle instance should be inserted
          SqfliteHelper.instance
              .updateAutherization(status: 'on-service-initial');
          authenticationRepository.onServiceInitial();
        } else {
          emit(state.copyWith(
            errorMsg: '_Bad State : The relevent bicycle cannot be accessed',
            status: QRScanStatus.failure,
          ));
          throw Exception();
        }
      } else {
        emit(state.copyWith(
          errorMsg: '_Bad State : Cannot Validate QR Code',
          status: QRScanStatus.failure,
        ));
        throw Exception();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onQRScanTryAgain(
    QRScanTryAgainEvent event,
    Emitter<QRScanState> emit,
  ) async {
    emit(state.copyWith(
      displayValue: '',
      errorMsg: 'Null',
      inProcessMsg: 'Validating the\nQR Code',
      status: QRScanStatus.initial,
    ));
  }

  Future<void> _onQRScanRollBack(
    QRScanRollBackEvent event,
    Emitter<QRScanState> emit,
  ) async {
    emit(const QRScanState());
  }
}
