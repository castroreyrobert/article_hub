
import 'package:equatable/equatable.dart';

class ProductCategoryEntity extends Equatable {
  final String slug;
  final String name;
  final String url;

  const ProductCategoryEntity({
    required this.slug,
    required this.name,
    required this.url
  });

  @override
  List<Object?> get props => [slug, name, url];

  static const ProductCategoryEntity all = ProductCategoryEntity(slug: "all", name: "All", url: "all");

}
