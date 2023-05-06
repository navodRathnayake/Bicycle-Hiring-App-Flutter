import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../Splash/Repository/splash_repository.dart';
part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final SplashRepository repository;
  late final StreamSubscription<RouteStatus> _routeSubscription;
  RouteBloc({required this.repository}) : super(const RouteState.initial()) {
    on<_RouteChangeEvent>(_onRouteChange);
    _routeSubscription = repository.status.listen((event) {
      add(_RouteChangeEvent(status: event));
    });
  }

  Future<void> _onRouteChange(
    _RouteChangeEvent event,
    Emitter<RouteState> emit,
  ) async {
    switch (event.status) {
      case RouteStatus.initial:
        return emit(const RouteState.initial());
      case RouteStatus.engage:
        return emit(const RouteState.engage());
    }
  }

  void dispose() => _routeSubscription.cancel();
}
