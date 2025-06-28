/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

ProductEntity productEntityFromJson(String str) => ProductEntity.fromJson(json.decode(str));

String productEntityToJson(ProductEntity data) => json.encode(data.toJson());

class ProductEntity {
    ProductEntity({
        required this.images,
        required this.thumbnail,
        required this.minimumOrderQuantity,
        required this.rating,
        required this.returnPolicy,
        required this.description,
        required this.weight,
        required this.warrantyInformation,
        required this.title,
        required this.tags,
        required this.discountPercentage,
        required this.reviews,
        required this.price,
        required this.meta,
        required this.shippingInformation,
        required this.id,
        required this.availabilityStatus,
        required this.category,
        required this.stock,
        required this.sku,
        required this.brand,
        required this.dimensions,
    });

    List<String> images;
    String thumbnail;
    int minimumOrderQuantity;
    double rating;
    String returnPolicy;
    String description;
    int weight;
    String warrantyInformation;
    String title;
    List<String> tags;
    double discountPercentage;
    List<Review> reviews;
    double price;
    Meta meta;
    String shippingInformation;
    int id;
    String availabilityStatus;
    String category;
    int stock;
    String sku;
    String brand;
    Dimensions dimensions;

    factory ProductEntity.fromJson(Map<dynamic, dynamic> json) => ProductEntity(
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
        minimumOrderQuantity: json["minimumOrderQuantity"],
        rating: json["rating"]?.toDouble(),
        returnPolicy: json["returnPolicy"],
        description: json["description"],
        weight: json["weight"],
        warrantyInformation: json["warrantyInformation"],
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        discountPercentage: json["discountPercentage"]?.toDouble(),
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        price: json["price"]?.toDouble(),
        meta: Meta.fromJson(json["meta"]),
        shippingInformation: json["shippingInformation"],
        id: json["id"],
        availabilityStatus: json["availabilityStatus"],
        category: json["category"],
        stock: json["stock"],
        sku: json["sku"],
        brand: json["brand"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
        "minimumOrderQuantity": minimumOrderQuantity,
        "rating": rating,
        "returnPolicy": returnPolicy,
        "description": description,
        "weight": weight,
        "warrantyInformation": warrantyInformation,
        "title": title,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "discountPercentage": discountPercentage,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "price": price,
        "meta": meta.toJson(),
        "shippingInformation": shippingInformation,
        "id": id,
        "availabilityStatus": availabilityStatus,
        "category": category,
        "stock": stock,
        "sku": sku,
        "brand": brand,
        "dimensions": dimensions.toJson(),
    };
}

class Dimensions {
    Dimensions({
        required this.depth,
        required this.width,
        required this.height,
    });

    double depth;
    double width;
    double height;

    factory Dimensions.fromJson(Map<dynamic, dynamic> json) => Dimensions(
        depth: json["depth"]?.toDouble(),
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
    );

    Map<dynamic, dynamic> toJson() => {
        "depth": depth,
        "width": width,
        "height": height,
    };
}

class Meta {
    Meta({
        required this.createdAt,
        required this.qrCode,
        required this.barcode,
        required this.updatedAt,
    });

    DateTime createdAt;
    String qrCode;
    String barcode;
    DateTime updatedAt;

    factory Meta.fromJson(Map<dynamic, dynamic> json) => Meta(
        createdAt: DateTime.parse(json["createdAt"]),
        qrCode: json["qrCode"],
        barcode: json["barcode"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "qrCode": qrCode,
        "barcode": barcode,
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Review {
    Review({
        required this.date,
        required this.reviewerName,
        required this.reviewerEmail,
        required this.rating,
        required this.comment,
    });

    DateTime date;
    String reviewerName;
    String reviewerEmail;
    int rating;
    String comment;

    factory Review.fromJson(Map<dynamic, dynamic> json) => Review(
        date: DateTime.parse(json["date"]),
        reviewerName: json["reviewerName"],
        reviewerEmail: json["reviewerEmail"],
        rating: json["rating"],
        comment: json["comment"],
    );

    Map<dynamic, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
        "rating": rating,
        "comment": comment,
    };
}
