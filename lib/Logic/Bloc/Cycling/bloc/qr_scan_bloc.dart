import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'qr_scan_event.dart';
part 'qr_scan_state.dart';

class QRScanBloc extends Bloc<QRScanEvent, QRScanState> {
  QRScanBloc() : super(const QRScanState()) {
    on<QRScanOnDetectEvent>(_onQRScanOnDetect);
    on<QRScanTryAgainEvent>(_onQRScanTryAgain);
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
        // call bicycle api and check the state
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
}
