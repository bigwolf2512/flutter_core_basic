import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../configs/app_key.dart';
import '../../configs/backend.dart';
import '../spref_core.dart';

final HttpLink _httpLink = HttpLink(BackendHost.BACKEND_HTTP);

final AuthLink _authLink = AuthLink(
    getToken: () async {
      final token = SPrefCore.prefs.get(AppKey.xToken).toString();
      // print("x-token api- $token");
      return token;
    },
    headerKey: BACKEND_TOKEN_HEADER);

final Link _link = _authLink.concat(_httpLink);
final _wsLink = WebSocketLink(BackendHost.BACKEND_WSS,
    config: SocketClientConfig(
        autoReconnect: true,
        initialPayload: () async {
          final token =  SPrefCore.prefs.get(AppKey.xToken);
          // print("x-token api- $token");
          return {"x-token": token};
        }));

final GraphQLClient graphqlClient = GraphQLClient(
  cache: GraphQLCache(),
  link: Link.split((request) => request.isSubscription, _wsLink, _link),
);

