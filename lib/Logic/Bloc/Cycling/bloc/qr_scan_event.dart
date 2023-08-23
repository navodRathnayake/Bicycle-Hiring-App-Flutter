part of 'qr_scan_bloc.dart';

class QRScanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QRScanOnDetectEvent extends QRScanEvent {
  final String displayValue;
  QRScanOnDetectEvent({required this.displayValue});

  @override
  List<Object> get props => [displayValue];
}

class QRScanTryAgainEvent extends QRScanEvent {}

class QRScanRollBackEvent extends QRScanEvent {}
