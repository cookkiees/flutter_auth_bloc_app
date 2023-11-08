part of 'home_bloc.dart';

class HomeState extends Equatable {
  final UserByIDBaseEntity? user;
  final String? error;

  const HomeState({this.user, this.error});

  @override
  List<Object?> get props => [user, error];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  const HomeSuccess({UserByIDBaseEntity? user}) : super(user: user);
}

final class HomeError extends HomeState {
  const HomeError({String? error}) : super(error: error);
}
