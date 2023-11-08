import 'package:authentication_with_bloc_app/app/modules/home/domain/entities/user_by_id_base_entity.dart';

class UserByIDBaseModels extends UserByIDBaseEntity {
  const UserByIDBaseModels({
    int? id,
    String? name,
    String? email,
    String? profilepicture,
    String? location,
    String? createdat,
  }) : super(
          id: id,
          name: name,
          email: email,
          profilepicture: profilepicture,
          location: location,
          createdat: createdat,
        );

  factory UserByIDBaseModels.fromJson(Map<String, dynamic> json) {
    return UserByIDBaseModels(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilepicture: json['profilepicture'],
      location: json['location'],
      createdat: json['createdat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilepicture': profilepicture,
      'location': location,
      'createdat': createdat,
    };
  }
}
