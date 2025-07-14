import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:floor/floor.dart';
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
@Entity(tableName: "products", primaryKeys: ["id"])
class ProductModel {

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

  const ProductModel({
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

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
        images: entity.images,
        tags: entity.tags,
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

   ProductEntity toEntityInstanceMethod() { // Or just toEntity()
     return ProductEntity(
         images: images, // 'this' refers to the current ProductModel instance
         tags: this.tags,
         thumbnail: this.thumbnail,
         rating: this.rating,
         returnPolicy: this.returnPolicy,
         description: this.description,
         weight: this.weight,
         title: this.title,
         discountPercentage: this.discountPercentage,
         price: this.price,
         id: this.id,
         availabilityStatus: this.availabilityStatus,
         category: this.category,
         stock: this.stock,
         sku: this.sku,
         brand: this.brand
     );
   }

}

@JsonSerializable()
@Entity(tableName: "recent_products", primaryKeys: ["id"])
class RecentProductModel {
  const RecentProductModel({
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

  factory RecentProductModel.fromJson(Map<String, dynamic> json) => _$RecentProductModelFromJson(json);

  factory RecentProductModel.fromEntity(ProductEntity entity) {
    return RecentProductModel(
        images: entity.images,
        tags: entity.tags,
        thumbnail: entity.thumbnail,
        rating: entity.rating,
        returnPolicy: entity.returnPolicy,
        description: entity.description,
        weight: entity.weight,
        title: entity.title,
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

  ProductEntity toEntityInstanceMethod() { // Or just toEntity()
    return ProductEntity(
        images: this.images, // 'this' refers to the current model instance
        tags: this.tags,
        thumbnail: this.thumbnail,
        rating: this.rating,
        returnPolicy: this.returnPolicy,
        description: this.description,
        weight: this.weight,
        title: this.title,
        discountPercentage: this.discountPercentage,
        price: this.price,
        id: this.id,
        availabilityStatus: this.availabilityStatus,
        category: this.category,
        stock: this.stock,
        sku: this.sku,
        brand: this.brand
    );
  }
}
