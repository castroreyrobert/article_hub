import '../../../core/resources/data_state.dart';
import '../../../core/resources/use_case.dart';
import '../../entities/products/product_entity.dart';
import '../../repositories/products/product_repository.dart';

class GetProductsByCategoryUseCase implements UseCase<DataState<List<ProductEntity>>, String> {
  final ProductRepository productRepository;
  GetProductsByCategoryUseCase(this.productRepository);

  @override
  Future<DataState<List<ProductEntity>>> invoke({String ? params}) async {
    return productRepository.getProductsByCategory(params!);
  }
}