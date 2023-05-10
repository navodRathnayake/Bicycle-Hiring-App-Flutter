library app;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/Logic/Bloc/Settings/settings_bloc.dart';
import 'package:final_project/Logic/Cubit/Network/network_cubit.dart';
import 'package:final_project/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constraints/constraints.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(create: (_) => SettingsBloc()),
        BlocProvider<NetworkCubit>(
            create: (_) => NetworkCubit(connectivity: Connectivity())),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Final Project',
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(iconSize: iconSize, iconColor: iconColor)),
            iconTheme: const IconThemeData(size: 64),
            useMaterial3: true,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: (state.themeModeStatus == AppThemeMode.lightMode)
              ? ThemeMode.light
              : ThemeMode.dark,
          home: const AuthController(),
        );
      },
    );
  }
}
