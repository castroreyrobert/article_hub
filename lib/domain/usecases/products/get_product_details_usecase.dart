import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/domain/repositories/products/product_repository.dart';

class GetProductDetailsUseCase implements UseCase<DataState<ProductEntity>, int> {

  GetProductDetailsUseCase(this.repository);

  final ProductRepository repository;

  @override
  Future<DataState<ProductEntity>> invoke({int ? params}) async {
    return repository.getProductDetails(params!);
  }
}