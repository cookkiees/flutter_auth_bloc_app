import 'package:authentication_with_bloc_app/app/core/services/service_api.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/data/models/auth_user_base_models.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/data/sources/auth_user_login_api_request.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/data/sources/auth_user_register_api_request.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/login/bloc/login_bloc.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/register/bloc/register_bloc.dart';

import '../../../../core/services/service_api_result.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl._();
  static final AuthRepositoryImpl _instance = AuthRepositoryImpl._();
  static AuthRepositoryImpl get instance => _instance;

  @override
  Future<ApiResult<AuthUserBaseModels>> getUserLogin(LoginEvent event) {
    final request = AuthUserLoginApiRequest(
      email: event.email,
      password: event.password,
    );
    final response = ApiService.instance.request(request, isJsonEncode: true);
    return response;
  }

  @override
  Future<ApiResult<AuthUserBaseModels>> getUserRegister(RegisterEvent event) {
    final request = AuthUserRegisterApiRequest(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    final response = ApiService.instance.request(request, isJsonEncode: true);
    return response;
  }
}
