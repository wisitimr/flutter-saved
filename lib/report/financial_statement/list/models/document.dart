import 'package:equatable/equatable.dart';

class Document extends Equatable {
  const Document({
    required this.id,
    required this.code,
    required this.name,
  });

  final String id;
  final String code;
  final String name;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json['id'],
        code: json['code'],
        name: json['name'],
      );

  @override
  List<Object> get props => [id, code, name];
}
