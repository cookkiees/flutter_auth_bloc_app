import 'package:authentication_with_bloc_app/app/core/services/service_api_request.dart';
import 'package:authentication_with_bloc_app/app/modules/home/data/models/user_by_id_base_models.dart';

class UserByIDApiRequest implements ApiRequest<UserByIDBaseModels> {
  final String userId;

  UserByIDApiRequest({required this.userId});
  @override
  UserByIDBaseModels Function(Map<String, dynamic> p1) get decoder =>
      UserByIDBaseModels.fromJson;

  @override
  Map<String, String>? get headers => {
        'Content-Type': 'application/json',
      };

  @override
  String get method => 'GET';

  @override
  Map<String, dynamic>? get params => {};

  @override
  String get path => 'users/$userId';
}
