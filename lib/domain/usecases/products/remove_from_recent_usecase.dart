
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';

import '../../repositories/products/product_repository.dart';

class RemoveFromRecentUseCase implements UseCase<void, ProductEntity> {
  final ProductRepository productRepository;

  RemoveFromRecentUseCase(this.productRepository);

  @override
  Future<void> invoke({ProductEntity ? params}) {
   return productRepository.removeFromRecentProducts(params!);
  }
}