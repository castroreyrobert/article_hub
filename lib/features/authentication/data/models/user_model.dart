import 'package:article_hub/features/authentication/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class LoginUserModel extends LoginUserEntity {
    String  accessToken;
    String  refreshToken;
    int  id;
    String  username;
    String  email;
    String firstName;
    String lastName;
    String gender;
    String image;

  LoginUserModel({
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

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => _$LoginUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserModelToJson(this);



}