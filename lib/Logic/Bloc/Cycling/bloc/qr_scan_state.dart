part of 'qr_scan_bloc.dart';

enum QRScanStatus { initial, inProcess, success, failure }

class QRScanState extends Equatable {
  final String displayValue;
  final QRScanStatus status;
  final String errorMsg;
  final String inProcessMsg;

  const QRScanState({
    this.displayValue = '',
    this.status = QRScanStatus.initial,
    this.errorMsg = 'Null',
    this.inProcessMsg = 'Validating The\nQR Code',
  });

  QRScanState copyWith({
    String? displayValue,
    QRScanStatus? status,
    String? errorMsg,
    String? inProcessMsg,
  }) {
    return QRScanState(
      displayValue: displayValue ?? this.displayValue,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      inProcessMsg: inProcessMsg ?? this.inProcessMsg,
    );
  }

  @override
  List<Object?> get props => [displayValue, status, errorMsg, inProcessMsg];
}
