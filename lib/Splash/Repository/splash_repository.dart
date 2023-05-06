library splash_repository;

import 'dart:async';

enum RouteStatus { initial, engage }

class SplashRepository {
  final StreamController<RouteStatus> _controller = StreamController();

  Stream<RouteStatus> get status async* {
    yield RouteStatus.initial;
    await Future.delayed(const Duration(seconds: 10));
    yield RouteStatus.engage;
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}
