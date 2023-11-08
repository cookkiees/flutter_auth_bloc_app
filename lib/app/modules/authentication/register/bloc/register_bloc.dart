import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/helpers/app_logger.dart';
import '../../../../core/services/service_api_result_type.dart';
import '../../../../data/local_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_user_entity.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) => _handleRegisterUser(event, emit));
  }
  Future<AuthUserBaseEntity?> _handleRegisterUser(
      RegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await AuthRepositoryImpl.instance.getUserRegister(event);
      if (response.result == ApiResultType.success) {
        await LocalStorage.saveToken("${response.data?.data?.token}");
        await LocalStorage.saveUserId(response.data?.data?.id ?? 0);
        emit(RegisterSuccess(response.data));
        return response.data;
      } else if (response.result == ApiResultType.failure) {
        AppLogger.logError(response.message.toString());
        emit(RegisterFailure(failure: response.message.toString()));
        return null;
      } else {
        AppLogger.logError(response.message.toString());
        return null;
      }
    } catch (e) {
      emit(RegisterError(error: e.toString()));
      AppLogger.logError(e.toString());
      return null;
    }
  }
}
