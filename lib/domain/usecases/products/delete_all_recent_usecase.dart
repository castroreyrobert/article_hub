import '../../../core/resources/use_case.dart';
import '../../repositories/products/product_repository.dart';

class DeleteAllRecentUseCase implements UseCase<void, void> {
  final ProductRepository productRepository;
  DeleteAllRecentUseCase(this.productRepository);

  @override
  Future<void> invoke({void params}) {
    return productRepository.clearRecentProducts();
  }
}