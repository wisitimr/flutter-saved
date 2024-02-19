import 'package:saved/company/models/models.dart';

class Daybook {
  final String id;
  final String code;
  final String number;
  final String type;
  final String transactionDate;
  final CompanyModel company;
  // final Partner partner;
  // final List<DaybookDetail> details;

  Daybook({
    required this.id,
    required this.code,
    required this.number,
    required this.type,
    required this.transactionDate,
    required this.company,
    // required this.partner,
    // required this.details,
  });

  factory Daybook.fromJson(Map<String, dynamic> json) => Daybook(
        id: json['id'],
        code: json['code'],
        number: json['number'],
        type: json['type'],
        transactionDate: json['transactionDate'],
        company: CompanyModel.fromJson(json['company']),
        // partner: Partner.fromJson(json['partner']),
        // details: json['details']
        //     .map((data) => DaybookDetail.fromJson(data))
        //     .toList(),
      );
}
