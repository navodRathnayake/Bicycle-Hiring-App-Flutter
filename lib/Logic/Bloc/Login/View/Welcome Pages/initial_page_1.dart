library initial_page_1;

import 'package:final_project/Const/Widget/column_spacer.dart';
import 'package:flutter/material.dart';

class InitialPage1 extends StatelessWidget {
  const InitialPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/welcome page 1 background.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(onTap: () {}, child: const Text('Skip')),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hire Your',
                        style: Theme.of(context).textTheme.displaySmall),
                    Text('Bicycle Today!',
                        style: Theme.of(context).textTheme.displayMedium),
                    const Text(
                        'Use bicycles/ e-bicycles as your main transportation service to save money and be a very healthy person.'),
                    const ColumnSpacer(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('1/3'),
                            const ColumnSpacer(height: 5),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset('Assets/icons/swip.png')),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
