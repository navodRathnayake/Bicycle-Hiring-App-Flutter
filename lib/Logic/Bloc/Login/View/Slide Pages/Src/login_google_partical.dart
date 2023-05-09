library login_google_partical;

import 'package:flutter/material.dart';

class LoginGooglePartical extends StatelessWidget {
  const LoginGooglePartical({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          objectCircularYellow(),
          objectMiniCircularYellow(),
          objectSideCircularYellow(),
          objectSideCircularRed(),
          objectSqureGreen(),
          objectSqureBlue(),
        ],
      ),
    );
  }
}

Widget objectCircularYellow() {
  return const Positioned(
    top: -25,
    right: -25,
    child: CircleAvatar(
      radius: 50,
      backgroundColor: Colors.amberAccent,
    ),
  );
}

Widget objectMiniCircularYellow() {
  return const Positioned(
    top: 75,
    right: 60,
    child: CircleAvatar(
      radius: 10,
      backgroundColor: Colors.amberAccent,
    ),
  );
}

Widget objectSideCircularYellow() {
  return const Positioned(
    top: 300,
    left: -25,
    child: CircleAvatar(
      radius: 25,
      backgroundColor: Colors.amberAccent,
    ),
  );
}

Widget objectSideCircularRed() {
  return const Positioned(
    bottom: 300,
    right: -55,
    child: CircleAvatar(
      radius: 40,
      backgroundColor: Colors.red,
    ),
  );
}

Widget objectSqureGreen() {
  return Positioned(
    bottom: 100,
    left: -35,
    child: RotationTransition(
      turns: const AlwaysStoppedAnimation(60 / 360),
      child: Container(
        width: 50,
        height: 100,
        color: Colors.green,
      ),
    ),
  );
}

Widget objectSqureBlue() {
  return Positioned(
    top: 100,
    right: -35,
    child: RotationTransition(
      turns: const AlwaysStoppedAnimation(60 / 360),
      child: Container(
        width: 50,
        height: 100,
        color: Colors.blue,
      ),
    ),
  );
}
