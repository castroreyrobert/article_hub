import 'package:article_hub/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductListResponse {
   List<ProductModel> ? products;
   String ? status;

  ProductListResponse({this.products, this.status});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => _$ProductListResponseFromJson(json);

}

@JsonSerializable()
class ProductModel extends ProductEntity {
   final List<String> ? images;
   final String ? thumbnail;
   final double ? rating;
   final String ? returnPolicy;
   final String ? description;
   final int ? weight;
   final String ? title;
   final List<String> ? tags;
   final double ? discountPercentage;
   final double ? price;
   final int ? id;
   final String ? availabilityStatus;
   final String ? category;
   final int ? stock;
   final String ? sku;
   final String ? brand;

  ProductModel({
    this.images,
    this.thumbnail,
    this.rating,
    this.returnPolicy,
    this.description,
    this.weight,
    this.title,
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

   @override
   List<Object?> get props => [
     images,
     thumbnail,
     rating,
     returnPolicy,
     description,
     weight,
     title,
     tags,
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
