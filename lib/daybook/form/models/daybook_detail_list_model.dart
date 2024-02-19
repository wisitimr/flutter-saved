import 'package:equatable/equatable.dart';
import 'package:saved/models/models.dart';

class DaybookDetailListModel extends Equatable {
  const DaybookDetailListModel({
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
  final MsAccount account;

  factory DaybookDetailListModel.fromJson(Map<String, dynamic> json) =>
      DaybookDetailListModel(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        amount: json['amount'],
        account: MsAccount.fromJson(json['account']),
      );

  @override
  List<Object> get props => [id, name, type, amount];
}
