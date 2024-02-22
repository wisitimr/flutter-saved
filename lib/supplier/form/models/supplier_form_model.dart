import 'package:equatable/equatable.dart';

class SupplierFormModel extends Equatable {
  const SupplierFormModel({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phone,
    required this.contact,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  final String id;
  final String code;
  final String name;
  final String address;
  final String phone;
  final String contact;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  factory SupplierFormModel.fromJson(Map<String, dynamic> json) =>
      SupplierFormModel(
        id: json['id'] ?? '',
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        address: json['address'] ?? '',
        phone: json['phone'] ?? '',
        contact: json['contact'] ?? '',
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
        address,
        phone,
        contact,
        createdBy,
        createdAt,
        updatedBy,
        updatedAt,
      ];
}
