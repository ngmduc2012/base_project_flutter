
import 'dart:developer' as d;

import '../../app/services/graphql/graphql.dart';
import '../../app/services/graphql/user_query.dart';
import '../modles/user.dart';


abstract class Graphql {
  Future<User> login(String email, String password);

}

class GraphqlImpl implements Graphql {
  final GraphQLService graphQLService;

  const GraphqlImpl({required this.graphQLService});

  @override
  Future<User> login(String email, String password) async {
    final result = await graphQLService.performQuery(
      UserQuery.login,
      variables: {"email": email, "password": password},
    );
    if (result?.hasException == true) {
      throw result!.exception!;
    }
    return User.fromJson(result!.data?["login"]);
  }


}