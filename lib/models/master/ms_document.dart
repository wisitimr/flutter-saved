import 'package:equatable/equatable.dart';

class MsDocument extends Equatable {
  const MsDocument({
    required this.id,
    required this.code,
    required this.name,
  });

  final String id;
  final String code;
  final String name;

  factory MsDocument.fromJson(Map<String, dynamic> json) => MsDocument(
        id: json['id'],
        code: json['code'],
        name: json['name'],
      );

  @override
  List<Object> get props => [id, code, name];
}
