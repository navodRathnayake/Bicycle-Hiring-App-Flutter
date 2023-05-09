library login_page;

import 'package:final_project/Logic/Cubit/Network/network_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Snack_bars/imp_snackbars.dart';
import 'Src/login_app_detail.dart';
import 'Src/login_google_partical.dart';

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
        backgroundColor: Colors.amber,
        body: Stack(
          children: [
            const LoginGooglePartical(),
            LoginAppDetail(themeData: themeData),
          ],
        ),
      ),
    );
  }
}
