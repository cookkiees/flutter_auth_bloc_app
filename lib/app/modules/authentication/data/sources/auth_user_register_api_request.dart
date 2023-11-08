import 'package:authentication_with_bloc_app/app/core/services/service_api_request.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/data/models/auth_user_base_models.dart';

class AuthUserRegisterApiRequest implements ApiRequest<AuthUserBaseModels> {
  final String name;
  final String email;
  final String password;

  AuthUserRegisterApiRequest(
      {required this.name, required this.email, required this.password});

  @override
  AuthUserBaseModels Function(Map<String, dynamic> p1) get decoder =>
      AuthUserBaseModels.fromJson;

  @override
  Map<String, String>? get headers => {
        'Content-Type': 'application/json',
      };

  @override
  String get method => 'POST';

  @override
  Map<String, dynamic>? get params => {
        'name': name,
        'email': email,
        'password': password,
      };

  @override
  String get path => 'authaccount/registration';
}
