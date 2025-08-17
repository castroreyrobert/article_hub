import 'package:article_hub/core/configs/flavor_config.dart';
import 'package:article_hub/core/utils/constants.dart';

import 'main.dart';

void main() {
  mainCommon(flavor: Flavor.prod, baseUrl: baseUrlProd, name: "Prod");
}