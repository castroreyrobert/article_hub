import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
    ProductEntity({
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
    });

    List<String> ? images;
    String ? thumbnail;
    double ? rating;
    String ? returnPolicy;
    String ? description;
    int ? weight;
    String ? title;
    List<String> ? tags;
    double ? discountPercentage;
    double ? price;
    int ? id;
    String ? availabilityStatus;
    String ? category;
    int ? stock;
    String ? sku;
    String ? brand;

    factory ProductEntity.fromJson(Map<dynamic, dynamic> json) => ProductEntity(
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
        rating: json["rating"]?.toDouble(),
        returnPolicy: json["returnPolicy"],
        description: json["description"],
        weight: json["weight"],
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        price: json["price"]?.toDouble(),
        id: json["id"],
        availabilityStatus: json["availabilityStatus"],
        category: json["category"],
        stock: json["stock"],
        sku: json["sku"],
        brand: json["brand"]
    );

    Map<dynamic, dynamic> toJson() => {
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": thumbnail,
        "rating": rating,
        "returnPolicy": returnPolicy,
        "description": description,
        "weight": weight,
        "title": title,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "discountPercentage": discountPercentage,
        "price": price,
        "id": id,
        "availabilityStatus": availabilityStatus,
        "category": category,
        "stock": stock,
        "sku": sku,
        "brand": brand
    };

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
