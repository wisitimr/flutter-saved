import 'package:equatable/equatable.dart';

class MsPaymentMethod extends Equatable {
  const MsPaymentMethod({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory MsPaymentMethod.fromJson(Map<String, dynamic> json) =>
      MsPaymentMethod(
        id: json['id'],
        name: json['name'],
      );

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
