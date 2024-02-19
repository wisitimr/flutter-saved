import 'package:equatable/equatable.dart';

class MaterialModel extends Equatable {
  const MaterialModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.type,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  final String id;
  final String code;
  final String name;
  final String description;
  final String type;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
        id: json['id'] ?? '',
        code: json['code'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        type: json['type'] ?? '',
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
        type,
        createdBy,
        createdAt,
        updatedBy,
        updatedAt,
      ];
}
