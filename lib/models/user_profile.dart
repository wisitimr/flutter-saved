import 'package:saved/company/models/company_model.dart';

class UserProfile {
  final String? id;
  final String? username;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? role;
  final List<CompanyModel> companies;

  UserProfile({
    required this.id,
    required this.username,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.companies,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'],
        username: json['username'],
        fullName: json['fullName'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        role: json['role'],
        companies: (json['companies'] as List)
            .map((data) => CompanyModel.fromJson(data))
            .toList(),
      );
}
