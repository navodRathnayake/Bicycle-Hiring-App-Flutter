library app;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_project/Autheriztion/autherization_bloc.dart';
import 'package:final_project/Logic/Bloc/Login/View/page_slider.dart';
import 'package:final_project/Logic/Bloc/Login/auth/forget%20password/confirm%20otp/confirm_otp_bloc.dart';
import 'package:final_project/Logic/Bloc/OCR/bloc/ocr_bloc.dart';
import 'package:final_project/Logic/Bloc/Profile/View/profile_completion_page.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/account_completion_bloc.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/pin_code_form_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/add_new_creadit_card_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/add_creadit_form_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/recent_activity_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/transaction_chart_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/bloc/transaction_bloc.dart';
import 'package:final_project/Logic/Bloc/Settings/settings_bloc.dart';
import 'package:final_project/Logic/Cubit/Network/network_cubit.dart';
import 'package:final_project/Routes/routes.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:final_project/Services/repository/user%20repository/user_repository.dart';
import 'package:final_project/Splash/View/splash_activity.dart';
import 'package:final_project/bottom_navigation_bar_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constraints/constraints.dart';

class App extends StatelessWidget {
  final AccountCompletionBloc accountCompletionBloc = AccountCompletionBloc();
  final AuthenticationRepository authenticationRepository;
  App({super.key, required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint('Firebase Device Code : $value');
    });

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => authenticationRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(create: (_) => SettingsBloc()),
          BlocProvider<NetworkCubit>(
              create: (_) => NetworkCubit(connectivity: Connectivity())),
          BlocProvider(
            create: (_) => AutherizationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: UserRepository(),
            ),
            child: AppView(authenticationRepository: authenticationRepository),
          ),
          BlocProvider<AccountCompletionBloc>(
              create: (_) => accountCompletionBloc),
          BlocProvider<OCRBloc>(
              create: (_) => OCRBloc(
                  accountCompletionBloc: accountCompletionBloc,
                  authenticationRepository: authenticationRepository)),
          BlocProvider<PinCodeFormBloc>(
              create: (_) => PinCodeFormBloc(
                  accountCompletionBloc: accountCompletionBloc)),
          BlocProvider<AddNewCreaditCardBloc>(
            create: (_) => AddNewCreaditCardBloc(
                authenticationRepository: authenticationRepository,
                accountCompletionBloc: accountCompletionBloc),
          ),
          BlocProvider<AddCreaditFormBloc>(create: (_) => AddCreaditFormBloc()),
          BlocProvider<TransactionBloc>(create: (_) => TransactionBloc()),
          BlocProvider<TransactionChartBloc>(
              create: (_) => TransactionChartBloc()),
          BlocProvider<RecentActivityBloc>(create: (_) => RecentActivityBloc()),
          BlocProvider<ConfirmOTPBloc>(
              create: (_) => ConfirmOTPBloc(
                  authenticationRepository: authenticationRepository)),
        ],
        child: AppView(authenticationRepository: authenticationRepository),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  const AppView({super.key, required this.authenticationRepository});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Final Project',
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return BlocListener<AutherizationBloc, AutherizationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.initial:
                    _navigator.pushAndRemoveUntil<void>(
                      PageSlider.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.loginNonVerified:
                    _navigator.pushAndRemoveUntil<void>(
                      ProfileCompletion.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.logingVerified:
                    _navigator.pushAndRemoveUntil<void>(
                      BottomNavigationBarController.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.logout:
                    _navigator.pushAndRemoveUntil<void>(
                      PageSlider.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.loading:
                    _navigator.pushAndRemoveUntil<void>(
                      SplashActivity.route(),
                      (route) => false,
                    );
                }
              },
              child: child,
            );
          },
          theme: ThemeData(
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(iconSize: iconSize, iconColor: iconColor)),
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
          onGenerateRoute:
              Routes(authenticationRepository: widget.authenticationRepository)
                  .onGenerate,
        );
      },
    );
  }
}
