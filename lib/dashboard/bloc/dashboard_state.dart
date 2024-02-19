part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

final class DashboardLoaded extends DashboardState {
  const DashboardLoaded({
    this.userCount = 0,
    this.daybookCount = 0,
    this.accountCount = 0,
    this.supplierCount = 0,
    this.customerCount = 0,
    this.productCount = 0,
    this.materialCount = 0,
  });

  final int userCount;
  final int daybookCount;
  final int accountCount;
  final int supplierCount;
  final int customerCount;
  final int productCount;
  final int materialCount;

  @override
  List<Object> get props => [
        userCount,
        daybookCount,
        accountCount,
        supplierCount,
        customerCount,
        productCount,
        materialCount,
      ];
}

final class DashboardError extends DashboardState {
  @override
  List<Object> get props => [];
}
