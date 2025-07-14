
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';

import '../../repositories/products/product_repository.dart';

class AddToRecentUseCase implements UseCase<void, ProductEntity> {
  final ProductRepository productRepository;

  AddToRecentUseCase(this.productRepository);

  @override
  Future<void> invoke({ProductEntity ? params}) async {
   return productRepository.addRecentProduct(params!);
  }
}