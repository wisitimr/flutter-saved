import 'package:equatable/equatable.dart';
import 'package:saved/company/company.dart';

class MyProfile extends Equatable {
  const MyProfile({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.companies,
  });

  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final List<CompanyModel> companies;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        id: json['id'] ?? '',
        username: json['username'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'] ?? '',
        role: json['role'] ?? '',
        companies: (json['companies'] as List)
            .map((data) => CompanyModel.fromJson(data))
            .toList(),
      );

  @override
  List<Object> get props => [
        id,
        username,
        firstName,
        lastName,
        email,
        role,
        companies,
      ];
}
