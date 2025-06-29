
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/authentication/data/models/error_response.dart';
import 'package:article_hub/features/products/data/data_sources/product_api_services.dart';
import 'package:article_hub/features/products/data/models/product_model.dart';
import 'package:article_hub/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImp extends ProductRepository {
  final ProductApiServices apiServices;
  ProductRepositoryImp(this.apiServices);
  @override
  Future<DataState<List<ProductModel>>> getProducts() async {
    final response = await apiServices.getProducts();
    try {
      if (response.response.statusCode == 200) {
        print(response.data);
        return Success(data: response.data.products);
      } else {
        return Failure(ErrorResponse.fromJson(response.response.data));
      }
    } catch(e) {
      return Failure(ErrorResponse(message: "Something went wrong!"));
    }

  }
}