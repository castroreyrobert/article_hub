

import 'package:article_hub/domain/entities/products/product_category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_category_model.g.dart';

@JsonSerializable()
class ProductCategoryModel extends ProductCategoryEntity {
  final String slug;
  final String name;
  final String url;

  const ProductCategoryModel({
    required this.slug,
    required this.name,
    required this.url
  }): super(slug: slug, name: name, url: url);

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => _$ProductCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryModelToJson(this);

  @override
  List<Object?> get props => [
    slug,
    name,
    url
  ];

  factory ProductCategoryModel.fromEntity(ProductCategoryEntity entity) {
    return ProductCategoryModel(
      slug: entity.slug ,
      name: entity.name,
      url: entity.url
    );
  }
}

