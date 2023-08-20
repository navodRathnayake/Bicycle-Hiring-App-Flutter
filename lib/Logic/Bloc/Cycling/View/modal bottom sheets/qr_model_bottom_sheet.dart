library qr_modal_bottom_sheet;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/qr_scan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

void qrModalBottomSheet(
    {required BuildContext context, required ThemeData themeData}) {
  showModalBottomSheet<void>(
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: BlocBuilder<QRScanBloc, QRScanState>(
          builder: (context, state) {
            if (state.status == QRScanStatus.initial) {
              return const QRScanInitial();
            } else if (state.status == QRScanStatus.inProcess) {
              return const QRScanInProcess();
            } else if (state.status == QRScanStatus.success) {
              return const QRScanSuccess();
            } else if (state.status == QRScanStatus.failure) {
              return QRScanFailure(themeData: themeData);
            } else {
              return QRScanFailure(themeData: themeData);
            }
          },
        ),
      );
    },
  );
}

class QRScanInitial extends StatelessWidget {
  const QRScanInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          children: [
            ColumnSpacer(height: 30),
            Text('QR Scanner',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ColumnSpacer(height: 30),
            Text('Place the QR code in the area'),
            Text('Scanning will be start automatically'),
            ColumnSpacer(height: 30),
          ],
        ),
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              MobileScanner(
                onDetect: (barcodes) {
                  debugPrint('Scan Has Been Done !');
                  debugPrint('${barcodes.raw[0]['displayValue']}');
                  BlocProvider.of<QRScanBloc>(context).add(QRScanOnDetectEvent(
                      displayValue: barcodes.raw[0]['displayValue']));
                },
              ),
              QRScannerOverlay(
                borderColor: Colors.blue,
              )
            ],
          ),
        ),
        const Column(
          children: [
            ColumnSpacer(height: 30),
            Text('CycleLanka.org'),
            ColumnSpacer(height: 30),
          ],
        ),
      ],
    );
  }
}

class QRScanInProcess extends StatelessWidget {
  const QRScanInProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<QRScanBloc, QRScanState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ColumnSpacer(height: 30),
              const CircularProgressIndicator(),
              const ColumnSpacer(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(state.inProcessMsg,
                    style: const TextStyle(
                      fontSize: 25,
                    )),
              ),
              const ColumnSpacer(height: 5),
              const Text('Card',
                  style: TextStyle(
                    fontSize: 25,
                  )),
              const ColumnSpacer(height: 10),
              const Text('It will take a while')
            ],
          );
        },
      ),
    );
  }
}

class QRScanSuccess extends StatelessWidget {
  const QRScanSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [Text('Success')],
      ),
    );
  }
}

class QRScanFailure extends StatelessWidget {
  final ThemeData themeData;
  const QRScanFailure({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: BlocBuilder<QRScanBloc, QRScanState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ColumnSpacer(height: 10),
                Image.asset('Assets/icons/sad.png',
                    color: themeData.colorScheme.onBackground),
                const ColumnSpacer(height: 10),
                const Text('Something',
                    style: TextStyle(
                      fontSize: 25,
                    )),
                const ColumnSpacer(height: 5),
                const Text('Went Wrong',
                    style: TextStyle(
                      fontSize: 25,
                    )),
                const ColumnSpacer(height: 5),
                const Text('Buddy!',
                    style: TextStyle(
                      fontSize: 25,
                    )),
                const ColumnSpacer(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    state.errorMsg.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                const ColumnSpacer(height: 30),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<QRScanBloc>(context)
                        .add(QRScanTryAgainEvent());
                  },
                  child: const Text('Try Again'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
