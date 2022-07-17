import 'package:base_project/core/values/languages/translations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../values/languages/translations.dart';

abstract class ExceptionHelper {
  static String getErrorMessage(dynamic e) {
    if (e is OperationException) {
      if (e.graphqlErrors.isNotEmpty) {
        return e.graphqlErrors.first.message;
      }

      if (e.linkException != null) {
        return e.linkException.toString();
      }
    }
    return AppTranslations.errorSever;
  }

  static int getErrorStatus(OperationException e) {
    return e.graphqlErrors.first.extensions!["response"]["statusCode"] ?? 404;
  }
}
