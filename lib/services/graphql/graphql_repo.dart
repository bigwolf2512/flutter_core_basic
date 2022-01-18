import '../../print_log.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';

import 'graphql_client.dart';

class GraphqlRepository {
  Future<QueryResult> query(
    String? query, {
    Map<String, dynamic>? variables,
    FetchPolicy? fetchPolicy,
    String? variablesParams,
  }) {
    var document = generateGQL(
        type: 'query', document: query, variablesParams: variablesParams);
    return graphqlClient.query(QueryOptions(
        document: document,
        variables: variables ?? Map(),
        fetchPolicy: fetchPolicy));
  }

  Future<QueryResult> mutate(
    String mutation, {
    Map<String, dynamic>? variables,
    Context? context,
    String? variablesParams,
  }) {
    return graphqlClient.mutate(MutationOptions(
        document: generateGQL(
            type: 'mutation',
            document: mutation,
            variablesParams: variablesParams),
        variables: variables ?? Map(),
        fetchPolicy: FetchPolicy.noCache,
        context: context));
  }

  clearCache() {
    graphqlClient.resetStore();
  }

  DocumentNode generateGQL(
      {required String type,
      String? document,
      List<String>? documents,
      String? variablesParams}) {
    String tmp = '$type${variablesParams ?? ''} {';
    if (document != null) {
      tmp += 'g0: $document';
    } else {
      if (documents != null)
        for (var i = 0; i < documents.length; i++) {
          tmp += '\ng$i: ${documents[i]}';
        }
    }
    tmp += '}';
    tmp = tmp.replaceAll(RegExp('\\s{2,}', multiLine: true), " ");
    printLog('query - $tmp');
    return parseString(tmp);
  }

  handleException(QueryResult result, {bool showDataResult = false}) {
    printLog("handleException: ${result.exception}");
    if (showDataResult == true) printLog("result.data: ${result.data}");
  }
}
