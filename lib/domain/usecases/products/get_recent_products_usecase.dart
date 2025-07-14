import '../../../core/resources/use_case.dart';
import '../../entities/products/product_entity.dart';
import '../../repositories/products/product_repository.dart';

class GetRecentProductsUseCase implements UseCase<List<ProductEntity>, void> {
  final ProductRepository productRepository;
  GetRecentProductsUseCase(this.productRepository);

  @override
  Future<List<ProductEntity>> invoke({void params}) {
    return productRepository.getRecentProducts();
  }
}