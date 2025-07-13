// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) =>
    ProductListResponse(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ProductListResponseToJson(
        ProductListResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
      'status': instance.status,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      mImages:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mTags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mThumbnail: json['thumbnail'] as String?,
      mRating: (json['rating'] as num?)?.toDouble(),
      mReturnPolicy: json['returnPolicy'] as String?,
      mDescription: json['description'] as String?,
      mWeight: (json['weight'] as num?)?.toInt(),
      mTitle: json['title'] as String?,
      mDiscountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      mPrice: (json['price'] as num?)?.toDouble(),
      mId: (json['id'] as num?)?.toInt(),
      mAvailabilityStatus: json['availabilityStatus'] as String?,
      mCategory: json['category'] as String?,
      mStock: (json['stock'] as num?)?.toInt(),
      mSku: json['sku'] as String?,
      mBrand: json['brand'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'thumbnail': instance.mThumbnail,
      'rating': instance.mRating,
      'returnPolicy': instance.mReturnPolicy,
      'description': instance.mDescription,
      'weight': instance.mWeight,
      'images': instance.mImages,
      'title': instance.mTitle,
      'discountPercentage': instance.mDiscountPercentage,
      'price': instance.mPrice,
      'id': instance.mId,
      'availabilityStatus': instance.mAvailabilityStatus,
      'category': instance.mCategory,
      'stock': instance.mStock,
      'sku': instance.mSku,
      'brand': instance.mBrand,
      'tags': instance.mTags,
    };
