import 'package:authentication_with_bloc_app/app/modules/authentication/login/bloc/login_bloc.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/register/bloc/register_bloc.dart';

import '../../../../core/services/service_api_result.dart';
import '../entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<ApiResult<AuthUserBaseEntity>> getUserLogin(LoginEvent event);
  Future<ApiResult<AuthUserBaseEntity>> getUserRegister(RegisterEvent event);
}
