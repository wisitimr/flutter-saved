import 'package:equatable/equatable.dart';

class ProductFormModel extends Equatable {
  const ProductFormModel({
    required this.id,
    required this.code,
    required this.name,
    required this.detail,
    required this.price,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  final String id;
  final String code;
  final String name;
  final String detail;
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
        detail: json['detail'] ?? '',
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
        detail,
        price,
        createdBy,
        createdAt,
        updatedBy,
        updatedAt,
      ];
}
