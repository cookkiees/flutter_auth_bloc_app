import '../../domain/entities/auth_user_entity.dart';

class AuthUserBaseModels extends AuthUserBaseEntity {
  const AuthUserBaseModels({
    int? code,
    String? message,
    AuthUserDataEntity? data,
  }) : super(
          code: code,
          message: message,
          data: data,
        );

  factory AuthUserBaseModels.fromJson(Map<String, dynamic> json) {
    return AuthUserBaseModels(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? AuthUserDataModels.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }
}

class AuthUserDataModels extends AuthUserDataEntity {
  const AuthUserDataModels({
    int? id,
    String? name,
    String? email,
    String? token,
  }) : super(
          id: id,
          name: name,
          email: email,
          token: token,
        );

  factory AuthUserDataModels.fromJson(Map<String, dynamic> json) {
    return AuthUserDataModels(
      id: json['Id'],
      name: json['Name'],
      email: json['Email'],
      token: json['Token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Email': email,
      'Token': token,
    };
  }
}
