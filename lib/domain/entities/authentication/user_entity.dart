
import 'package:equatable/equatable.dart';

class LoginUserEntity extends Equatable {

  final String ? accessToken;
  final String ? refreshToken;
  final int ? id;
  final String ? username;
  final String ? email;
  final String ? firstName;
  final String ? lastName;
  final String ? gender;
  final String ? image;

  const LoginUserEntity({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image
  });

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    id,
    username,
    email,
    firstName,
    lastName,
    gender,
  ];
}
