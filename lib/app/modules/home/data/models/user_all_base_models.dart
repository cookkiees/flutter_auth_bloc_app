import 'package:authentication_with_bloc_app/app/modules/home/domain/entities/user_all_base_entity.dart';

class UserAllBaseModels extends UserAllBaseEntity {
  const UserAllBaseModels({
    int? page,
    int? perPage,
    int? totalrecord,
    int? totalPages,
    List<UserAllDataModels>? data,
  }) : super(
          page: page,
          perPage: perPage,
          totalrecord: totalrecord,
          totalPages: totalPages,
          data: data,
        );

  factory UserAllBaseModels.fromJson(Map<String, dynamic> json) {
    return UserAllBaseModels(
      page: json['page'],
      perPage: json['per_page'],
      totalrecord: json['totalrecord'],
      totalPages: json['total_pages'],
      data: (json['data'] as List<dynamic>?)
          ?.map((v) => UserAllDataModels.fromJson(v))
          .toList(),
    );
  }
}

class UserAllDataModels extends UserAllDataEntity {
  const UserAllDataModels({
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

  factory UserAllDataModels.fromJson(Map<String, dynamic> json) {
    return UserAllDataModels(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilepicture: json['profilepicture'],
      location: json['location'],
      createdat: json['createdat'],
    );
  }
}
