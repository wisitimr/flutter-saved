import 'package:equatable/equatable.dart';

class ProductFormModel extends Equatable {
  const ProductFormModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.price,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  final String id;
  final String code;
  final String name;
  final String description;
  final double price;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  factory ProductFormModel.fromJson(Map<String, dynamic> json) =>
      ProductFormModel(
        id: json['id'] ?? '',
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        price: json['price'] ?? 0,
        createdBy: json['createdBy'] ?? '',
        createdAt: json['createdAt'] ?? '',
        updatedBy: json['updatedBy'] ?? '',
        updatedAt: json['updatedAt'] ?? '',
      );

  @override
  List<Object> get props => [
        id,
        code,
        name,
        description,
        price,
        createdBy,
        createdAt,
        updatedBy,
        updatedAt,
      ];
}
