part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final AuthUserBaseEntity? user;
  final String? error;
  final String? failure;
  const LoginState({this.error, this.user, this.failure});

  @override
  List<Object?> get props => [error, user];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailure extends LoginState {
  const LoginFailure({super.failure});
}

final class LoginSuccess extends LoginState {
  const LoginSuccess(AuthUserBaseEntity? user) : super(user: user);
}

final class LoginError extends LoginState {
  const LoginError({super.error});
}
