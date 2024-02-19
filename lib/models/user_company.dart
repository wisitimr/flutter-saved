class UserCompany {
  final String id;
  final List<Company> companies;

  UserCompany({
    required this.id,
    required this.companies,
  });

  factory UserCompany.fromJson(Map<String, dynamic> json) => UserCompany(
        id: json['id'],
        companies: (json['companies'] as List)
            .map((data) => Company.fromJson(data))
            .toList(),
      );
}

class Company {
  final String id;
  final String code;
  final String name;

  Company({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json['id'],
        code: json['code'],
        name: json['name'],
      );
}
