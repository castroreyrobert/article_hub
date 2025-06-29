import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
    ProductEntity({
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
