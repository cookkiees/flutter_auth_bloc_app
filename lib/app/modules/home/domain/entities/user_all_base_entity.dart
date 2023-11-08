import 'package:equatable/equatable.dart';

class UserAllBaseEntity extends Equatable {
  final int? page;
  final int? perPage;
  final int? totalrecord;
  final int? totalPages;
  final List<UserAllDataEntity>? data;

  const UserAllBaseEntity(
      {this.page, this.perPage, this.totalrecord, this.totalPages, this.data});

  @override
  List<Object?> get props => [page, perPage, totalrecord, totalPages, data];
}

class UserAllDataEntity extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? profilepicture;
  final String? location;
  final String? createdat;

  const UserAllDataEntity(
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
