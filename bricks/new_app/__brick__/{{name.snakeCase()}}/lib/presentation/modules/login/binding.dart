import 'package:get/get.dart';

import '../../../app/services/graphql/graphql.dart';
import '../../../app/services/http_client.dart';
import '../../../app/services/localization.dart';
import '../../../data/repositories/graphql.dart';
import '../../../data/repositories/http.dart';
import '../home/controller.dart';
import 'controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GraphQLService>(GraphQLService(), permanent: true);
    Get.put<HttpClient>(HttpClientImpl(), permanent: true);
    Get.put<Http>(
      HttpImpl(httpClient: Get.find()),
    );
    Get.put<Graphql>(
      GraphqlImpl(
        graphQLService: Get.find<GraphQLService>(),
      ),
    );

    Get.put(LoginController(Get.find<Http>()));
  }
}
