import 'package:equatable/equatable.dart';
import 'package:findigitalservice/report/tb12/models/child_account_balance.dart';

class AccountBalance extends Equatable {
  const AccountBalance({
    required this.accountGroup,
    required this.sumForwardDr,
    required this.sumForwardCr,
    required this.sumJanDr,
    required this.sumJanCr,
    required this.sumFebDr,
    required this.sumFebCr,
    required this.sumMarDr,
    required this.sumMarCr,
    required this.sumAprDr,
    required this.sumAprCr,
    required this.sumMayDr,
    required this.sumMayCr,
    required this.sumJunDr,
    required this.sumJunCr,
    required this.sumJulDr,
    required this.sumJulCr,
    required this.sumAugDr,
    required this.sumAugCr,
    required this.sumSepDr,
    required this.sumSepCr,
    required this.sumOctDr,
    required this.sumOctCr,
    required this.sumNovDr,
    required this.sumNovCr,
    required this.sumDecDr,
    required this.sumDecCr,
    required this.sumTotalDr,
    required this.sumTotalCr,
    required this.sumBalance,
    required this.child,
  });

  final String accountGroup;
  final double sumForwardDr;
  final double sumForwardCr;
  final double sumJanDr;
  final double sumJanCr;
  final double sumFebDr;
  final double sumFebCr;
  final double sumMarDr;
  final double sumMarCr;
  final double sumAprDr;
  final double sumAprCr;
  final double sumMayDr;
  final double sumMayCr;
  final double sumJunDr;
  final double sumJunCr;
  final double sumJulDr;
  final double sumJulCr;
  final double sumAugDr;
  final double sumAugCr;
  final double sumSepDr;
  final double sumSepCr;
  final double sumOctDr;
  final double sumOctCr;
  final double sumNovDr;
  final double sumNovCr;
  final double sumDecDr;
  final double sumDecCr;
  final double sumTotalDr;
  final double sumTotalCr;
  final double sumBalance;
  final List<ChildAccountBalance> child;

  factory AccountBalance.fromJson(Map<String, dynamic> json) => AccountBalance(
        accountGroup: json["accountGroup"] ?? "",
        sumForwardDr: json["sumForwardDr"] ?? 0,
        sumForwardCr: json["sumForwardCr"] ?? 0,
        sumJanDr: json["sumJanDr"] ?? 0,
        sumJanCr: json["sumJanCr"] ?? 0,
        sumFebDr: json["sumFebDr"] ?? 0,
        sumFebCr: json["sumFebCr"] ?? 0,
        sumMarDr: json["sumMarDr"] ?? 0,
        sumMarCr: json["sumMarCr"] ?? 0,
        sumAprDr: json["sumAprDr"] ?? 0,
        sumAprCr: json["sumAprCr"] ?? 0,
        sumMayDr: json["sumMayDr"] ?? 0,
        sumMayCr: json["sumMayCr"] ?? 0,
        sumJunDr: json["sumJunDr"] ?? 0,
        sumJunCr: json["sumJunCr"] ?? 0,
        sumJulDr: json["sumJulDr"] ?? 0,
        sumJulCr: json["sumJulCr"] ?? 0,
        sumAugDr: json["sumAugDr"] ?? 0,
        sumAugCr: json["sumAugCr"] ?? 0,
        sumSepDr: json["sumSepDr"] ?? 0,
        sumSepCr: json["sumSepCr"] ?? 0,
        sumOctDr: json["sumOctDr"] ?? 0,
        sumOctCr: json["sumOctCr"] ?? 0,
        sumNovDr: json["sumNovDr"] ?? 0,
        sumNovCr: json["sumNovCr"] ?? 0,
        sumDecDr: json["sumDecDr"] ?? 0,
        sumDecCr: json["sumDecCr"] ?? 0,
        sumTotalDr: json["sumTotalDr"] ?? 0,
        sumTotalCr: json["sumTotalCr"] ?? 0,
        sumBalance: json["sumBalance"] ?? 0,
        child: (json['child'] as List)
            .map((data) => ChildAccountBalance.fromJson(data))
            .toList(),
      );

  @override
  List<Object> get props => [
        accountGroup,
        sumForwardDr,
        sumForwardCr,
        sumJanDr,
        sumJanCr,
        sumFebDr,
        sumFebCr,
        sumMarDr,
        sumMarCr,
        sumAprDr,
        sumAprCr,
        sumMayDr,
        sumMayCr,
        sumJunDr,
        sumJunCr,
        sumJulDr,
        sumJulCr,
        sumAugDr,
        sumAugCr,
        sumSepDr,
        sumSepCr,
        sumOctDr,
        sumOctCr,
        sumNovDr,
        sumNovCr,
        sumDecDr,
        sumDecCr,
        sumTotalDr,
        sumTotalCr,
        sumBalance,
        child,
      ];
}
