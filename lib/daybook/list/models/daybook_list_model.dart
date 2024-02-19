import 'package:equatable/equatable.dart';

class DaybookListModel extends Equatable {
  const DaybookListModel({
    required this.id,
    required this.number,
    required this.invoice,
    required this.document,
    required this.transactionDate,
  });

  final String id;
  final String number;
  final String invoice;
  final String document;
  final String transactionDate;

  factory DaybookListModel.fromJson(Map<String, dynamic> json) =>
      DaybookListModel(
        id: json['id'],
        number: json['number'],
        invoice: json['invoice'],
        document: json['document']['name'],
        transactionDate: json['transactionDate'],
      );

  @override
  List<Object> get props => [id, number, invoice, document, transactionDate];
}
