library points;

import 'package:final_project/Account/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Const/Widget/row_spacer.dart';

class Points extends StatelessWidget {
  final ThemeData themeData;
  const Points({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      BlocProvider.of<AccountBloc>(context)
                          .state
                          .user
                          .points
                          .toString(),
                      style: const TextStyle(color: Colors.black)),
                  const RowSpacer(width: 5),
                  Image.asset(
                    'Assets/icons/points.png',
                    scale: 2,
                  )
                ],
              ),
            ));
      },
    );
  }
}
