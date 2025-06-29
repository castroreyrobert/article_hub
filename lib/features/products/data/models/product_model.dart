import 'package:article_hub/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

class ProductListResponse {
  final List<ProductModel> products;
  final String status;

  ProductListResponse({required this.products, required this.status});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      products: (json['products'] as List<dynamic>)
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );
  }
}

@JsonSerializable()
class ProductModel extends ProductEntity {
  final List<String> images;
  final String thumbnail;
  final double rating;
  final String returnPolicy;
  final String description;
  final int weight;
  final String title;
  final List<String> tags;
  final double discountPercentage;
  final double price;
  final int id;
  final String availabilityStatus;
  final String category;
  final int stock;
  final String sku;
  final String brand;

  ProductModel({
    required this.images,
    required this.thumbnail,
    required this.rating,
    required this.returnPolicy,
    required this.description,
    required this.weight,
    required this.title,
    required this.tags,
    required this.discountPercentage,
    required this.price,
    required this.id,
    required this.availabilityStatus,
    required this.category,
    required this.stock,
    required this.sku,
    required this.brand
  }) : super(
      images: images,
      thumbnail: thumbnail,
      rating: rating,
      returnPolicy: returnPolicy,
      description: description ,
      weight: weight,
      title: title,
      tags: tags,
      discountPercentage: discountPercentage,
      price: price,
      id: id,
      availabilityStatus: availabilityStatus,
      category: category,
      stock: stock,
      sku: sku,
      brand: brand
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}
