part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  final AuthUserBaseEntity? user;
  final String? error;
  final String? failure;
  const RegisterState({this.error, this.user, this.failure});

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterFailure extends RegisterState {
  const RegisterFailure({super.failure});
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess(AuthUserBaseEntity? user) : super(user: user);
}

final class RegisterError extends RegisterState {
  const RegisterError({super.error});
}
