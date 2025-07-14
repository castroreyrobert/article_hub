import '../../../core/resources/use_case.dart';
import '../../entities/products/product_entity.dart';
import '../../repositories/products/product_repository.dart';

class GetFavoriteProductsUseCase implements UseCase<List<ProductEntity>, void> {
  final ProductRepository productRepository;
  GetFavoriteProductsUseCase(this.productRepository);

  @override
  Future<List<ProductEntity>> invoke({void params}) {
    return productRepository.getFavoriteProducts();
  }
}