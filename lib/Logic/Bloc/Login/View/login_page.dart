library login_page;

import 'package:final_project/Logic/Cubit/Network/network_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Const/Widget/column_spacer.dart';
import '../../../../Const/Widget/row_spacer.dart';
import '../../../../Services/Auth/firebase_auth_service.dart';
import './Snack_bars/imp_snackbars.dart';

class LoginPage extends StatelessWidget {
  final ThemeData themeData;
  const LoginPage({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          ScaffoldMessenger.of(context)
              .showSnackBar(networkDisconnectedSnackBar);
        }
        if (state is NetworkConnected && state.status == NetworkStatus.wifi) {
          ScaffoldMessenger.of(context)
              .showSnackBar(networkConnectedWifiSnackBar);
        }
        if (state is NetworkConnected && state.status == NetworkStatus.mobile) {
          ScaffoldMessenger.of(context)
              .showSnackBar(networkConnectedWifiSnackBar);
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              children: [
                const CircularProgressIndicator(),
                const ColumnSpacer(height: 10),
                Text('HIRE YOUR BICYCLE TODAY!',
                    style: themeData.textTheme.bodyLarge),
                const Text(
                    'This is the demo text. Add a relevant text field here.'),
                const ColumnSpacer(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: FirebaseAuthService().signInWithGoogle,
                      icon: Image.asset('Assets/google.png'),
                    ),
                    const RowSpacer(width: 25),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('Assets/fb.png'),
                    ),
                  ],
                ),
                const ColumnSpacer(height: 10),
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const ColumnSpacer(height: 10)
              ],
            )
          ],
        ),
      ),
    );
  }
}
