import 'package:authentication_with_bloc_app/app/modules/home/data/repositories/user_repository_impl.dart';
import 'package:authentication_with_bloc_app/app/modules/home/domain/entities/user_by_id_base_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/helpers/app_logger.dart';
import '../../../../core/services/service_api_result_type.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeUserInitialEvent>((event, emit) => _getUsers(event, emit, true));
    on<HomeUserRefreshEvent>((event, emit) => _getUsers(event, emit, false));
  }

  Future<void> _getUsers(HomeEvent event, emit, isLoading) async {
    if (isLoading) {
      emit(HomeLoading());
    }
    final user = await _handleUserById(event, emit);

    emit(HomeSuccess(user: user));
  }

  Future<UserByIDBaseEntity?> _handleUserById(
      HomeEvent event, Emitter<HomeState> emit) async {
    try {
      final response = await UserRepositoryImpl.instance.getUserByID(event);
      if (response.result == ApiResultType.success) {
        return response.data;
      } else {
        AppLogger.logError(response.message.toString());
        return null;
      }
    } catch (e) {
      emit(HomeError(error: e.toString()));
      AppLogger.logError(e.toString());
      return null;
    }
  }
}
