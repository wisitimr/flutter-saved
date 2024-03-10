import 'package:equatable/equatable.dart';

class DaybookDetailFormModel extends Equatable {
  const DaybookDetailFormModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.type,
    required this.amount,
    required this.daybook,
    required this.account,
    required this.company,
  });

  final String id;
  final String name;
  final String detail;
  final String type;
  final double amount;
  final String daybook;
  final String account;
  final String company;

  factory DaybookDetailFormModel.fromJson(Map<String, dynamic> json) =>
      DaybookDetailFormModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        detail: json['detail'] ?? '',
        type: json['type'] ?? '',
        amount: json['amount'] ?? '',
        daybook: json['daybook'] ?? '',
        account: json['account'] ?? '',
        company: json['company'] ?? '',
      );

  @override
  List<Object> get props => [
        id,
        name,
        detail,
        type,
        amount,
        daybook,
        account,
        company,
      ];
}
