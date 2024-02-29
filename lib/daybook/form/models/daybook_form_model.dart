import 'package:equatable/equatable.dart';
import 'package:findigitalservice/daybook/form/models/models.dart';

class DaybookFormModel extends Equatable {
  const DaybookFormModel({
    required this.id,
    required this.number,
    required this.invoice,
    required this.document,
    required this.transactionDate,
    // required this.company,
    required this.supplier,
    required this.customer,
    required this.paymentMethod,
    required this.daybookDetail,
  });

  final String id;
  final String number;
  final String invoice;
  final String document;
  final String transactionDate;
  // final String company;
  final String supplier;
  final String customer;
  final String paymentMethod;
  final List<DaybookDetailListModel> daybookDetail;

  factory DaybookFormModel.fromJson(Map<String, dynamic> json) =>
      DaybookFormModel(
        id: json['id'] ?? '',
        number: json['number'] ?? '',
        invoice: json['invoice'] ?? '',
        document: json['document'] ?? '',
        transactionDate: json['transactionDate'] ?? '',
        // company: json['company'],
        supplier: json['supplier'] ?? '',
        customer: json['customer'] ?? '',
        paymentMethod: json['paymentMethod'] ?? '',
        daybookDetail: (json['daybookDetails'] as List)
            .map((data) => DaybookDetailListModel.fromJson(data))
            .toList(),
      );

  @override
  List<Object> get props => [
        id,
        number,
        invoice,
        document,
        transactionDate,
        supplier,
        customer,
        paymentMethod,
      ];
}
