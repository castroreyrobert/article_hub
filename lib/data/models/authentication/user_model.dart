import 'package:article_hub/domain/entities/authentication/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
    final String accessToken;
    final String refreshToken;
    final int id;
    final String username;
    final String email;
    final String firstName;
    final String lastName;
    final String gender;
    final String image;

  const UserModel({
    required this.accessToken,
    required this.refreshToken,
    required this.id ,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);



}