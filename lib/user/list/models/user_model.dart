import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companies,
    required this.role,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final List companies;
  final String role;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        username: json['username'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'] ?? '',
        companies: json['companies'] ?? [],
        role: json['role'] ?? '',
        createdBy: json['createdBy'] ?? '',
        createdAt: json['createdAt'] ?? '',
        updatedBy: json['updatedBy'] ?? '',
        updatedAt: json['updatedAt'] ?? '',
      );

  @override
  List<Object> get props => [
        id,
        username,
        firstName,
        lastName,
        email,
        companies,
        role,
        createdBy,
        createdAt,
        updatedBy,
        updatedAt,
      ];
}
