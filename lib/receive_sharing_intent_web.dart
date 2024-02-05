library receive_sharing_intent_web;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class ReceiveSharingIntentWeb {
  static void registerWith(Registrar registrar) {
    final methodChannel = MethodChannel(
      'receive_sharing_intent/messages',
      const StandardMethodCodec(),
      registrar.messenger,
    );
    final eventChannel = PluginEventChannel(
      'receive_sharing_intent/events-media',
      const StandardMethodCodec(),
      registrar.messenger,
    );
    final instance = ReceiveSharingIntentWeb();
    eventChannel.setController(streamController);
    methodChannel.setMethodCallHandler(instance.handleMethodCall);
  }

  static StreamController streamController = StreamController();

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getInitialMedia':
        final uri = Uri.base;
        final text = uri.queryParameters['text'];
        if (text == null) return jsonEncode([]);
        final subject = uri.queryParameters['subject'];
        final media = SharedMediaFile(
          path: text,
          type: SharedMediaType.text,
          message: subject,
        );
        return jsonEncode([media.toMap()]);
      case 'reset':
        return;
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The receive_sharing_intent_web plugin "
                "for web doesn't implement "
                "the method '${call.method}'");
    }
  }
}
