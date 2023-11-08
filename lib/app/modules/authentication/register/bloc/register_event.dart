part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterEvent(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}

class UserRegisterEvent extends RegisterEvent {
  const UserRegisterEvent({
    required super.name,
    required super.email,
    required super.password,
  });
}
