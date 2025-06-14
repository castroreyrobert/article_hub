import 'package:article_hub/features/authentication/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

class LoginUserModel extends LoginUserEntity {
  const LoginUserModel ({
    String ? accessToken,
    String ? refreshToken,
    int ? id,
    String ? username,
    String ? email,
    String ? firstName,
    String ? lastName,
    String ? gender,
    String ? image
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) =>
      LoginUserModel(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        id: json['id'],
        username: json['username'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        image: json['image']
      );
}

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'password')
  String? password;

  LoginRequest({this.email, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

}