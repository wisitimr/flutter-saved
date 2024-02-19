class CompanyModel {
  final String id;
  final String code;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String contact;

  CompanyModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.contact,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'],
        address: json['address'],
        phone: json['phone'],
        contact: json['contact'],
      );
}
