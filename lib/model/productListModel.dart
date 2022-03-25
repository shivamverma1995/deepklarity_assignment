import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductListModel {
  final List<Product> products;
  ProductListModel({
    required this.products,
  });

  ProductListModel copyWith({
    List<Product>? products,
  }) {
    return ProductListModel(
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductListModel.fromMap(Map<String, dynamic> map) {
    return ProductListModel(
      products:
          List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductListModel.fromJson(String source) =>
      ProductListModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProductListModel(products: $products)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductListModel && listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;
}

class Product {
  final String productName;
  final String productURL;
  final double productRating;
  final String productDescription;
  Product({
    required this.productName,
    required this.productURL,
    required this.productRating,
    required this.productDescription,
  });

  Product copyWith({
    String? productName,
    String? productURL,
    double? productRating,
    String? productDescription,
  }) {
    return Product(
      productName: productName ?? this.productName,
      productURL: productURL ?? this.productURL,
      productRating: productRating ?? this.productRating,
      productDescription: productDescription ?? this.productDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productURL': productURL,
      'productRating': productRating,
      'productDescription': productDescription,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] ?? '',
      productURL: map['productURL'] ?? '',
      productRating: map['productRating']?.toDouble() ?? 0.0,
      productDescription: map['productDescription'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(productName: $productName, productURL: $productURL, productRating: $productRating, productDescription: $productDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.productName == productName &&
        other.productURL == productURL &&
        other.productRating == productRating &&
        other.productDescription == productDescription;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        productURL.hashCode ^
        productRating.hashCode ^
        productDescription.hashCode;
  }
}
