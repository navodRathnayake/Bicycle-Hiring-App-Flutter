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
  final XFile? xfile;
  final List<String?>? textLines;

  const OCRState._(
      {this.status = OCRStatus.initial, this.msg, this.xfile, this.textLines});
  const OCRState.initial() : this._();
  const OCRState.ocrProcess() : this._(status: OCRStatus.ocrProcess);
  const OCRState.ocrFailure() : this._(status: OCRStatus.ocrFailure);
  const OCRState.updateSuccess() : this._(status: OCRStatus.updateSucsses);
  const OCRState.updateFailure() : this._(status: OCRStatus.updateFailure);
  const OCRState(
      {required this.status,
      required this.msg,
      required this.xfile,
      required this.textLines});

  OCRState copyWith({
    OCRStatus? status,
    String? msg,
    XFile? xfile,
    List<String?>? textLines,
  }) {
    return OCRState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      xfile: xfile ?? this.xfile,
      textLines: textLines ?? this.textLines,
    );
  }

  @override
  List<Object?> get props => [status];
}
