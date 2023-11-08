import 'package:authentication_with_bloc_app/app/core/services/service_api.dart';
import 'package:authentication_with_bloc_app/app/core/services/service_api_result.dart';
import 'package:authentication_with_bloc_app/app/modules/home/data/models/user_by_id_base_models.dart';
import 'package:authentication_with_bloc_app/app/modules/home/data/sources/user_by_id_api_request.dart';
import 'package:authentication_with_bloc_app/app/modules/home/domain/repositories/user_reposiroty.dart';

import '../../presentation/bloc/home_bloc.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl._();
  static final UserRepositoryImpl _instance = UserRepositoryImpl._();
  static UserRepositoryImpl get instance => _instance;

  @override
  Future<ApiResult<UserByIDBaseModels>> getUserByID(HomeEvent event) async {
    final request = UserByIDApiRequest(userId: event.userId!);

    final response =
        await ApiService.instance.request(request, withAuthorization: true);
    return response;
  }
}
