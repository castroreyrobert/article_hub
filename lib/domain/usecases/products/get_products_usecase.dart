
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/domain/repositories/products/product_repository.dart';

class GetProductsUseCase implements UseCase<DataState<List<ProductEntity>>, void> {
  final ProductRepository productRepository;
  GetProductsUseCase(this.productRepository);

  @override
  Future<DataState<List<ProductEntity>>> invoke({void params}) async {
    return productRepository.getProducts();
  }
}