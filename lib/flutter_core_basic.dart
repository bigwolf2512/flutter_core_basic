export 'services/graphql/crud_repo.dart';
export 'services/graphql/graphql_repo.dart';
export 'services/graphql/graphql_client.dart';
export 'services/graphql/graphql_list_provider.dart';
export 'services/graphql/graphql_list_load_more_provider.dart';
export 'services/files/path_file_local.dart';
export 'services/files/service_file.dart';
export 'services/spref_core.dart';


export 'controllers/load_more_controller.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_core_basic/configs/backend.dart';

//
class FlutterCoreBasic {
  static const MethodChannel _channel = MethodChannel('flutter_core_basic');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
//

intConfig(
    {required BACKEND_API,
    required KEYAPI,
    required BACKEND_WSS,
    required BACKEND_HTTP}) {
  BackendHost.BACKEND_API = BACKEND_API;
  BackendHost.KEYAPI = KEYAPI;
  BackendHost.BACKEND_WSS = BACKEND_WSS;
  BackendHost.BACKEND_HTTP = BACKEND_HTTP;
}
