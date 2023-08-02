part of 'ocr_bloc.dart';

enum OCRStatus {
  initial,
  ocrProcess,
  ocrSuccess,
  ocrFailure,
  updateSucsses,
  updateFailure
}

class OCRState extends Equatable {
  final OCRStatus status;
  final String? msg;

  const OCRState._({this.status = OCRStatus.initial, this.msg});
  const OCRState.initial() : this._();
  const OCRState.ocrProcess() : this._(status: OCRStatus.ocrProcess);
  const OCRState.ocrFailure() : this._(status: OCRStatus.ocrFailure);
  const OCRState.updateSuccess() : this._(status: OCRStatus.updateSucsses);
  const OCRState.updateFailure() : this._(status: OCRStatus.updateFailure);

  @override
  List<Object?> get props => [status];
}
