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

   @JsonKey(name: "thumbnail")
   final String? mThumbnail;

   @JsonKey(name: "rating")
   final double? mRating;

   @JsonKey(name: "returnPolicy")
   final String? mReturnPolicy;
   @JsonKey(name: "description")

   final String? mDescription;
   @JsonKey(name: "weight")
   final int? mWeight;

   @JsonKey(name: "images")
   final List<String>? mImages;

   @JsonKey(name: "title")
   final String? mTitle;

   @JsonKey(name: "discountPercentage")
   final double? mDiscountPercentage;

   @JsonKey(name: "price")
   final double? mPrice;

   @PrimaryKey(autoGenerate: false)
   @JsonKey(name: "id")
   final int? mId;

   @JsonKey(name: "availabilityStatus")
   final String? mAvailabilityStatus;

   @JsonKey(name: "category")
   final String? mCategory;

   @JsonKey(name: "stock")
   final int? mStock;

   @JsonKey(name: "sku")
   final String? mSku;

   @JsonKey(name: "brand")
   final String? mBrand;

   @JsonKey(name: "tags")
   final List<String>? mTags;

  const ProductModel({
    this.mImages,
    this.mTags,
    this.mThumbnail,
    this.mRating,
    this.mReturnPolicy,
    this.mDescription,
    this.mWeight,
    this.mTitle,
    this.mDiscountPercentage,
    this.mPrice,
    this.mId,
    this.mAvailabilityStatus,
    this.mCategory,
    this.mStock,
    this.mSku,
    this.mBrand
  }): super(
      images: mImages,
      tags: mTags,
      thumbnail: mThumbnail,
      rating: mRating,
      returnPolicy: mReturnPolicy,
      description: mDescription,
      weight: mWeight,
      title: mTitle,
      discountPercentage: mDiscountPercentage,
      price: mPrice,
      id: mId,
      availabilityStatus: mAvailabilityStatus,
      category: mCategory,
      stock: mStock,
      sku: mSku,
      brand: mBrand
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
        mImages: entity.images,
        mTags: entity.tags,
        mThumbnail: entity.thumbnail ?? "",
        mRating: entity.rating,
        mReturnPolicy: entity.returnPolicy,
        mDescription: entity.description,
        mWeight: entity.weight,
        mTitle: entity.title ?? "",
        mDiscountPercentage: entity.discountPercentage,
        mPrice: entity.price,
        mId: entity.id,
        mAvailabilityStatus: entity.availabilityStatus,
        mCategory: entity.category,
        mStock: entity.stock,
        mSku: entity.sku,
        mBrand: entity.brand
    );
  }

}
