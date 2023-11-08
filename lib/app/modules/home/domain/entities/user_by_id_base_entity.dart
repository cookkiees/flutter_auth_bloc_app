import 'package:equatable/equatable.dart';

class UserByIDBaseEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? profilepicture;
  final String? location;
  final String? createdat;

  const UserByIDBaseEntity(
      {this.id,
      this.name,
      this.email,
      this.profilepicture,
      this.location,
      this.createdat});

  @override
  List<Object?> get props =>
      [id, name, email, profilepicture, location, createdat];
}
