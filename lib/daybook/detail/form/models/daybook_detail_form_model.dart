import 'package:equatable/equatable.dart';

class DaybookDetailFormModel extends Equatable {
  const DaybookDetailFormModel({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.account,
  });

  final String id;
  final String name;
  final String type;
  final double amount;
  final String account;

  factory DaybookDetailFormModel.fromJson(Map<String, dynamic> json) =>
      DaybookDetailFormModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        amount: json['amount'] ?? '',
        account: json['account'] ?? '',
      );

  @override
  List<Object> get props => [
        id,
        name,
        type,
        amount,
        account,
      ];
}
