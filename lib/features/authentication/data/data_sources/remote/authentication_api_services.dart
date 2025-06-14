
import 'package:article_hub/core/utils/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/user_model.dart';
part 'authentication_api_services.g.dart';


@RestApi(baseUrl: authBaseURL)
abstract class AuthenticationApiServices {
  factory AuthenticationApiServices (Dio dio) = _AuthenticationApiServices;

  @POST("/auth/login")
  Future<HttpResponse<LoginUserModel>> login( {@Body() required LoginRequest loginRequest });
}