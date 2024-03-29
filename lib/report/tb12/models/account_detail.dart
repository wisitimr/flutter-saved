import 'package:equatable/equatable.dart';

class AccountDetail extends Equatable {
  const AccountDetail({
    required this.month,
    required this.date,
    required this.detail,
    required this.number,
    required this.amountDr,
    required this.amountCr,
  });

  final String month;
  final int date;
  final String detail;
  final String number;
  final double amountDr;
  final double amountCr;

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
        month: json['month'] ?? '',
        date: json['date'] ?? 0,
        detail: json['detail'] ?? '',
        number: json['number'] ?? '',
        amountDr: json['amountDr'] ?? 0,
        amountCr: json['amountCr'] ?? 0,
      );

  @override
  List<Object> get props => [
        month,
        date,
        detail,
        number,
        amountDr,
        amountCr,
      ];
}
