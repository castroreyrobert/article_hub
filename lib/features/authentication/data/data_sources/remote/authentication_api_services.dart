
import 'package:article_hub/core/utils/constants.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../models/login_request.dart';
import '../../models/user_model.dart';
part 'authentication_api_services.g.dart';


@RestApi(baseUrl: authBaseURL)
abstract class AuthenticationApiServices {
  factory AuthenticationApiServices (Dio dio, {String baseUrl}) = _AuthenticationApiServices;

  @POST("auth/login")
  @Headers(<String, dynamic>{ // Ensure Content-Type is set for JSON
    "Content-Type": "application/json",
    "Accept": "application/json"
  })
  Future<HttpResponse<LoginUserModel>> login(@Body() LoginRequest loginRequest);
}