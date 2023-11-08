import 'package:authentication_with_bloc_app/app/data/local_storage.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/data/repositories/auth_repository_impl.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/domain/entities/auth_user_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/helpers/app_logger.dart';
import '../../../../core/services/service_api_result_type.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserLoginEvent>((event, emit) => _handleLoginUser(event, emit));
  }
  Future<AuthUserBaseEntity?> _handleLoginUser(
      LoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await AuthRepositoryImpl.instance.getUserLogin(event);
      if (response.result == ApiResultType.success) {
        await LocalStorage.saveToken("${response.data?.data?.token}");
        await LocalStorage.saveUserId(response.data?.data?.id ?? 0);

        emit(LoginSuccess(response.data));

        return response.data;
      } else if (response.result == ApiResultType.failure) {
        AppLogger.logError(response.message.toString());
        emit(LoginFailure(failure: response.message.toString()));
        return null;
      } else {
        AppLogger.logError(response.message.toString());
        return null;
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
      AppLogger.logError(e.toString());
      return null;
    }
  }
}
