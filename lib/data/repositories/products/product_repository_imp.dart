
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/data/models/error_response.dart';
import 'package:article_hub/data/data_sources/remote/products/product_api_services.dart';
import 'package:article_hub/data/models/products/product_model.dart';
import 'package:article_hub/domain/repositories/products/product_repository.dart';

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