import 'package:equatable/equatable.dart';

class MsSupplier extends Equatable {
  const MsSupplier({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.tax,
    required this.phone,
    required this.contact,
    required this.company,
  });

  final String id;
  final String code;
  final String name;
  final String address;
  final String tax;
  final String phone;
  final String contact;
  final String company;

  factory MsSupplier.fromJson(Map<String, dynamic> json) => MsSupplier(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        address: json['address'],
        tax: json['tax'],
        phone: json['phone'],
        contact: json['contact'],
        company: json['company'],
      );

  @override
  List<Object> get props => [id, name];
}
