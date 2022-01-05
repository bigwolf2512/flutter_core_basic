
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterCoreBasic {
  static const MethodChannel _channel = MethodChannel('flutter_core_basic');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
