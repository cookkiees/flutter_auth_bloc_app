import 'package:authentication_with_bloc_app/app/core/services/service_api_result.dart';
import 'package:authentication_with_bloc_app/app/modules/home/domain/entities/user_by_id_base_entity.dart';

import '../../presentation/bloc/home_bloc.dart';

abstract class UserRepository {
  Future<ApiResult<UserByIDBaseEntity>> getUserByID(HomeEvent event);
}
