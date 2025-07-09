
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/domain/entities/products/product_category_entity.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/domain/repositories/products/product_repository.dart';

class GetProductCategoryUseCase implements UseCase<DataState<List<ProductCategoryEntity>>, void> {
  final ProductRepository productRepository;
  GetProductCategoryUseCase(this.productRepository);

  @override
  Future<DataState<List<ProductCategoryEntity>>> invoke({void params}) async {
    return productRepository.getProductCategories();
  }
}