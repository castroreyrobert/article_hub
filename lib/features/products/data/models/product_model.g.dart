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
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      thumbnail: json['thumbnail'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      returnPolicy: json['returnPolicy'] as String?,
      description: json['description'] as String?,
      weight: (json['weight'] as num?)?.toInt(),
      title: json['title'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      availabilityStatus: json['availabilityStatus'] as String?,
      category: json['category'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      brand: json['brand'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'images': instance.images,
      'thumbnail': instance.thumbnail,
      'rating': instance.rating,
      'returnPolicy': instance.returnPolicy,
      'description': instance.description,
      'weight': instance.weight,
      'title': instance.title,
      'tags': instance.tags,
      'discountPercentage': instance.discountPercentage,
      'price': instance.price,
      'id': instance.id,
      'availabilityStatus': instance.availabilityStatus,
      'category': instance.category,
      'stock': instance.stock,
      'sku': instance.sku,
      'brand': instance.brand,
    };
