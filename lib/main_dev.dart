
import 'package:article_hub/core/configs/flavor_config.dart';
import 'package:article_hub/core/utils/constants.dart';
import 'package:article_hub/main.dart';

void main() {
  mainCommon(flavor: Flavor.dev, baseUrl: authBaseURL, name: "Dev");
}