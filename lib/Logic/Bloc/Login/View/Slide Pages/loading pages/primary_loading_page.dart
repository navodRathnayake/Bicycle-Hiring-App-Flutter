library primary_loading_page;

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PrimaryLoadingPage extends StatefulWidget {
  const PrimaryLoadingPage({super.key});

  @override
  State<PrimaryLoadingPage> createState() => _PrimaryLoadingPageState();
}

class _PrimaryLoadingPageState extends State<PrimaryLoadingPage> {
  late SMITrigger ear;
  late SMITrigger eye;
  late SMITrigger bite;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300,
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RiveAnimation.asset(
                      'Assets/icons/hippo.riv',
                      onInit: (Artboard artboard) {
                        StateMachineController controller =
                            getRiveController(artboard);
                        ear = controller.findSMI('ear') as SMITrigger;
                        eye = controller.findSMI('eye') as SMITrigger;
                        bite = controller.findSMI('bite') as SMITrigger;
                      },
                    ),
                  )),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CYCLE LANKA',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        letterSpacing: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
