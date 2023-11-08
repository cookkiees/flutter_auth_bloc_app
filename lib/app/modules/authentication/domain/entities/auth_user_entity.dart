import 'package:equatable/equatable.dart';

class AuthUserBaseEntity extends Equatable {
  final int? code;
  final String? message;
  final AuthUserDataEntity? data;

  const AuthUserBaseEntity({this.code, this.message, this.data});

  @override
  List<Object?> get props => [code, message, data];
}

class AuthUserDataEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? token;

  const AuthUserDataEntity({this.id, this.name, this.email, this.token});

  @override
  List<Object?> get props => [id, name, email, token];
}
