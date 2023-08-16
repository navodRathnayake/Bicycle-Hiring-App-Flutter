library account_repository;

import 'dart:async';

import 'package:flutter/foundation.dart';

enum AccountStreamStatus { streamIdel, streamIn, streamOut }

class AccountStreamRepository {
  final _controller = StreamController<AccountStreamStatus>();

  Stream<AccountStreamStatus> get status async* {
    debugPrint('Stream started');
    yield AccountStreamStatus.streamIdel;
    yield* _controller.stream;
  }

  Future<void> streamIn() async {
    debugPrint('STREAM IN');
    _controller.add(AccountStreamStatus.streamIn);
  }

  Future<void> streamOut() async {
    debugPrint('STREAM OUT');
    _controller.add(AccountStreamStatus.streamOut);
  }

  Future<void> streamIdel() async {
    debugPrint('STREAM IDEL');
    _controller.add(AccountStreamStatus.streamIdel);
  }

  void dispose() => _controller.close();
}
