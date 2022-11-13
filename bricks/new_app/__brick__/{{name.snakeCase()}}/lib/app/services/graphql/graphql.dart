
import 'dart:developer' as d;

import 'package:{{name.snakeCase()}}/presentation/modules/home/controller.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../presentation/modules/login/controller.dart';
import '../../utils/domain.dart';
import '../../utils/exception.dart';

class GraphQLService {
  GraphQLClient? _client;
  String? uri;

  GraphQLService() {
    setUri(Domain.api);
  }

  void setUri(String uri) {
    this.uri = uri;
    HttpLink link = HttpLink(uri + "/graphql");
    _client = GraphQLClient(link: link, cache: GraphQLCache());
  }

  Future<QueryResult?> performQuery(String query,
      {required Map<String, dynamic> variables}) async {
    QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly);
    setAuth();
    final result = await _client?.query(options);
    // d.log("$result");
    verifyAuth(result);
    return result;
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic>? variables}) async {
    MutationOptions options =
        MutationOptions(document: gql(query), variables: variables!);
    setAuth();
    final result = await _client?.mutate(options);
    verifyAuth(result!);
    return result;
  }

  verifyAuth(QueryResult? result) {
    if (result?.hasException == true &&  LoginController.to.isLoggedIn) {
      if (ExceptionHelper.getErrorStatus(result!.exception!) == 401) {
        LoginController.to.logout2();
      }
    }
  }

  setAuth() {
    if (HomeController.to.accessToken != null) {
      _client = GraphQLClient(
        link: AuthLink(getToken: () => HomeController.to.accessToken)
            .concat(_client!.link),
        cache: GraphQLCache(),
      );
    }
  }
}
