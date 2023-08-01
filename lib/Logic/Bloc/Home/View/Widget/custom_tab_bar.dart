library custom_tab_bar;

import 'package:final_project/Logic/Bloc/Home/View/Widget/location_tile.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/news_list_tile.dart';
import 'package:final_project/Logic/Bloc/Home/View/Widget/recent_activity_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatefulWidget {
  final ThemeData themeData;
  const CustomTabBar({super.key, required this.themeData});

  @override
  State<CustomTabBar> createState() => _CustomTabBar();
}

class _CustomTabBar extends State<CustomTabBar> {
  List<String> tabs = [
    "Recent Activities",
    "Locations",
    "News",
  ];
  int current = 0;

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return 130;
      case 2:
        return 215;
      case 3:
        return 263;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return 128;
      case 1:
        return 75;
      case 2:
        return 45;
      case 3:
        return 50;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Widget> tabContentList = [
      ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => const RecentActivityList(),
      ),
      //TabContent1(),
      ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => const LocationTile(),
      ),
      ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) =>
            NewsTagTile(themeData: widget.themeData),
      ),
    ];
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
            width: size.width,
            height: size.height * 0.05,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: size.width,
                    height: size.height * 0.04,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: tabs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: index == 0 ? 10 : 23, top: 7),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: Text(
                                tabs[index],
                                style: GoogleFonts.ubuntu(
                                  fontSize: current == index ? 16 : 14,
                                  fontWeight: current == index
                                      ? FontWeight.w400
                                      : FontWeight.w300,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.fastLinearToSlowEaseIn,
                  bottom: 0,
                  left: changePositionedOfLine(),
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(left: 10),
                    width: changeContainerWidth(),
                    height: size.height * 0.008,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: tabContentList[current],
            ),
          )
        ],
      ),
    );
  }
}

class TabContent1 extends StatelessWidget {
  const TabContent1({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecentActivityList();
  }
}

class TabContent2 extends StatelessWidget {
  const TabContent2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('B');
  }
}

class TabContent3 extends StatelessWidget {
  const TabContent3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('C');
  }
}
