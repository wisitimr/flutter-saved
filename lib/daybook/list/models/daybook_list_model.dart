import 'package:equatable/equatable.dart';
import 'package:saved/models/master/ms_customer.dart';
import 'package:saved/models/master/ms_supplier.dart';

class DaybookListModel extends Equatable {
  const DaybookListModel({
    required this.id,
    required this.number,
    required this.invoice,
    required this.document,
    required this.transactionDate,
    this.supplier,
    this.customer,
  });

  final String id;
  final String number;
  final String invoice;
  final String document;
  final String transactionDate;
  final MsSupplier? supplier;
  final MsCustomer? customer;

  factory DaybookListModel.fromJson(Map<String, dynamic> json) =>
      DaybookListModel(
        id: json['id'] ?? '',
        number: json['number'] ?? '',
        invoice: json['invoice'] ?? '',
        document: json['document']?['name'] ?? '',
        transactionDate: json['transactionDate'],
        supplier: json['supplier'] == null
            ? null
            : MsSupplier.fromJson(json['supplier']),
        customer: json['customer'] == null
            ? null
            : MsCustomer.fromJson(json['customer']),
      );

  @override
  List<Object> get props => [
        id,
        number,
        invoice,
        document,
        transactionDate,
      ];
}
