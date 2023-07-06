library profile_avater;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/Const/Widget/row_spacer.dart';
import 'package:flutter/material.dart';

import '../../../Home/View/Widget/custom_settings_icon.dart';
import '../../../Home/View/Widget/popup_settings_menu.dart';

class ProfileAvater extends StatelessWidget {
  final ThemeData themeData;
  const ProfileAvater({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 47,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                      backgroundColor: themeData.colorScheme.onSecondary,
                      radius: 45,
                      child: CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://th.bing.com/th/id/OIP.jAEnONxlpsGr8oF6yPHI9QHaHZ?pid=ImgDet&rs=1",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            const RowSpacer(width: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Markus D.', style: themeData.textTheme.headlineLarge),
                Text(
                  'sample@gmail.com',
                ),
              ],
            ),
          ],
        ),
        PopUpSettingsMenu(
            icon: Container(
          width: 40,
          child: CustomSettingsIcon(
            themeData: themeData,
          ),
        ))
      ],
    );
  }
}
