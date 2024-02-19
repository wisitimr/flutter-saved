class Account {
  final String id;
  final String code;
  final String name;
  final String description;
  final String type;
  final String company;

  Account({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.type,
    required this.company,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'],
        type: json['type'],
        company: json['company'],
      );
}
