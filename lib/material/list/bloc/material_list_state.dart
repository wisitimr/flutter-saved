part of 'material_list_bloc.dart';

enum Status { loading, success, failure, deleted, confirmation }

extension StatusX on Status {
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
  bool get isDeleted => this == Status.deleted;
  bool get isConfirmation => this == Status.confirmation;
}

@immutable
final class MaterialXState extends Equatable {
  const MaterialXState({
    this.status = Status.loading,
    this.message = '',
    this.materials = const <MaterialModel>[],
    this.filter = const <MaterialModel>[],
    this.selectedRowId = '',
  });

  final Status status;
  final String message;
  final List<MaterialModel> materials;
  final List<MaterialModel> filter;
  final String selectedRowId;

  MaterialXState copyWith({
    Status? status,
    String? message,
    List<MaterialModel>? materials,
    List<MaterialModel>? filter,
    String? selectedRowId,
  }) {
    return MaterialXState(
      status: status ?? this.status,
      message: message ?? this.message,
      materials: materials ?? this.materials,
      filter: filter ?? this.filter,
      selectedRowId: selectedRowId ?? this.selectedRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        materials,
        filter,
        selectedRowId,
      ];
}

final class MaterialLoading extends MaterialXState {
  @override
  List<Object> get props => [];
}

final class MaterialError extends MaterialXState {
  @override
  List<Object> get props => [];
}
