import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/list_string_type_converter.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductListResponse {
   List<ProductModel> ? products;
   String ? status;

  ProductListResponse({this.products, this.status});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => _$ProductListResponseFromJson(json);

}

@JsonSerializable()
@Entity(tableName: "products", primaryKeys: ["id"])
class ProductModel extends ProductEntity {
   final List<String> ? images;
   final String thumbnail;
   final double ? rating;
   final String ? returnPolicy;
   final String ? description;
   final int ? weight;
   final String title;
   final List<String> ? tags;
   final double ? discountPercentage;
   final double ? price;
   final int ? id;
   final String ? availabilityStatus;
   final String ? category;
   final int ? stock;
   final String ? sku;
   final String ? brand;

  const ProductModel({
    this.images,
    required this.thumbnail,
    this.rating,
    this.returnPolicy,
    this.description,
    this.weight,
    required this.title,
    this.tags,
    this.discountPercentage,
    this.price,
    this.id,
    this.availabilityStatus,
    this.category,
    this.stock,
    this.sku,
    this.brand
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
        images: entity.images,
        thumbnail: entity.thumbnail ?? "",
        rating: entity.rating,
        returnPolicy: entity.returnPolicy,
        description: entity.description,
        weight: entity.weight,
        title: entity.title ?? "",
        discountPercentage: entity.discountPercentage,
        price: entity.price,
        id: entity.id,
        availabilityStatus: entity.availabilityStatus,
        category: entity.category,
        stock: entity.stock,
        sku: entity.sku,
        brand: entity.brand
    );
  }

   @override
   List<Object?> get props => [
     thumbnail,
     rating,
     returnPolicy,
     description,
     weight,
     title,
     discountPercentage,
     price,
     id,
     availabilityStatus,
     category,
     stock,
     sku,
     brand
   ];

}
