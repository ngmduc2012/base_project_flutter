
import 'package:get/get.dart';

import '../../../app/services/graphql/graphql.dart';
import '../../../app/services/http_client.dart';
import '../../../app/services/localization.dart';
import '../../../data/repositories/graphql.dart';
import '../../../data/repositories/http.dart';
import 'controller.dart';


class SignUpBinding implements Bindings {
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
    Get.put(LocalizationService());
    Get.put(SignUpController(Get.find<Http>()));
  }
}
