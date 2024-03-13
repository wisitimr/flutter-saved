import 'package:equatable/equatable.dart';

class ChildAccountBalance extends Equatable {
  const ChildAccountBalance({
    required this.accountCode,
    required this.accountName,
    required this.forwardDr,
    required this.forwardCr,
    required this.janDr,
    required this.janCr,
    required this.febDr,
    required this.febCr,
    required this.marDr,
    required this.marCr,
    required this.aprDr,
    required this.aprCr,
    required this.mayDr,
    required this.mayCr,
    required this.junDr,
    required this.junCr,
    required this.julDr,
    required this.julCr,
    required this.augDr,
    required this.augCr,
    required this.sepDr,
    required this.sepCr,
    required this.octDr,
    required this.octCr,
    required this.novDr,
    required this.novCr,
    required this.decDr,
    required this.decCr,
    required this.totalDr,
    required this.totalCr,
    required this.balance,
  });

  final String accountCode;
  final String accountName;
  final double forwardDr;
  final double forwardCr;
  final double janDr;
  final double janCr;
  final double febDr;
  final double febCr;
  final double marDr;
  final double marCr;
  final double aprDr;
  final double aprCr;
  final double mayDr;
  final double mayCr;
  final double junDr;
  final double junCr;
  final double julDr;
  final double julCr;
  final double augDr;
  final double augCr;
  final double sepDr;
  final double sepCr;
  final double octDr;
  final double octCr;
  final double novDr;
  final double novCr;
  final double decDr;
  final double decCr;
  final double totalDr;
  final double totalCr;
  final double balance;

  factory ChildAccountBalance.fromJson(Map<String, dynamic> json) =>
      ChildAccountBalance(
        accountCode: json["accountCode"] ?? "",
        accountName: json["accountName"] ?? "",
        forwardDr: json["forwardDr"] ?? 0,
        forwardCr: json["forwardCr"] ?? 0,
        janDr: json["janDr"] ?? 0,
        janCr: json["janCr"] ?? 0,
        febDr: json["febDr"] ?? 0,
        febCr: json["febCr"] ?? 0,
        marDr: json["marDr"] ?? 0,
        marCr: json["marCr"] ?? 0,
        aprDr: json["aprDr"] ?? 0,
        aprCr: json["aprCr"] ?? 0,
        mayDr: json["mayDr"] ?? 0,
        mayCr: json["mayCr"] ?? 0,
        junDr: json["junDr"] ?? 0,
        junCr: json["junCr"] ?? 0,
        julDr: json["julDr"] ?? 0,
        julCr: json["julCr"] ?? 0,
        augDr: json["augDr"] ?? 0,
        augCr: json["augCr"] ?? 0,
        sepDr: json["sepDr"] ?? 0,
        sepCr: json["sepCr"] ?? 0,
        octDr: json["octDr"] ?? 0,
        octCr: json["octCr"] ?? 0,
        novDr: json["novDr"] ?? 0,
        novCr: json["novCr"] ?? 0,
        decDr: json["decDr"] ?? 0,
        decCr: json["decCr"] ?? 0,
        totalDr: json["totalDr"] ?? 0,
        totalCr: json["totalCr"] ?? 0,
        balance: json["balance"] ?? 0,
      );

  @override
  List<Object> get props => [
        accountCode,
        accountName,
        forwardDr,
        forwardCr,
        janDr,
        janCr,
        febDr,
        febCr,
        marDr,
        marCr,
        aprDr,
        aprCr,
        mayDr,
        mayCr,
        junDr,
        junCr,
        julDr,
        julCr,
        augDr,
        augCr,
        sepDr,
        sepCr,
        octDr,
        octCr,
        novDr,
        novCr,
        decDr,
        decCr,
        totalDr,
        totalCr,
        balance,
      ];
}
