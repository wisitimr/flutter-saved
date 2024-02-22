import 'package:equatable/equatable.dart';

class MsSupplier extends Equatable {
  const MsSupplier({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phone,
    required this.contact,
  });

  final String id;
  final String code;
  final String name;
  final String address;
  final String phone;
  final String contact;

  factory MsSupplier.fromJson(Map<String, dynamic> json) => MsSupplier(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        address: json['address'],
        phone: json['phone'],
        contact: json['contact'],
      );

  @override
  List<Object> get props => [
        id,
        code,
        name,
        phone,
        contact,
      ];
}
