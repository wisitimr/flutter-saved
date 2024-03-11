import 'package:equatable/equatable.dart';
import 'package:findigitalservice/models/master/ms_customer.dart';
import 'package:findigitalservice/models/master/ms_supplier.dart';

class FinancialStatementListModel extends Equatable {
  const FinancialStatementListModel({
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

  factory FinancialStatementListModel.fromJson(Map<String, dynamic> json) =>
      FinancialStatementListModel(
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
