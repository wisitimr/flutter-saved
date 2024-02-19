import 'package:equatable/equatable.dart';

class MsAccount extends Equatable {
  const MsAccount({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.type,
  });

  final String id;
  final String code;
  final String name;
  final String description;
  final String type;

  factory MsAccount.fromJson(Map<String, dynamic> json) => MsAccount(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'],
        type: json['type'],
      );

  @override
  List<Object> get props => [id, code, name, description, type];
}
