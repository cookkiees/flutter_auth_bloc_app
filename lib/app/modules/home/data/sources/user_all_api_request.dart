import 'package:authentication_with_bloc_app/app/core/services/service_api_request.dart';
import 'package:authentication_with_bloc_app/app/modules/home/data/models/user_all_base_models.dart';

class UserAllApiRequest implements ApiRequest<UserAllBaseModels> {
  final int page;

  UserAllApiRequest({required this.page});
  @override
  UserAllBaseModels Function(Map<String, dynamic> p1) get decoder =>
      UserAllBaseModels.fromJson;

  @override
  Map<String, String>? get headers => {
        'Content-Type': 'application/json',
      };

  @override
  String get method => 'GET';

  @override
  Map<String, dynamic>? get params => {'page': page.toString()};

  @override
  String get path => 'users';
}
