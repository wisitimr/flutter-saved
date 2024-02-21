part of 'material_list_bloc.dart';

enum MaterialListStatus {
  loading,
  success,
  failure,
  deleteConfirmation,
  deleted,
}

extension MaterialListStatusX on MaterialListStatus {
  bool get isLoading => this == MaterialListStatus.loading;
  bool get isSuccess => this == MaterialListStatus.success;
  bool get isFailure => this == MaterialListStatus.failure;
  bool get isDeleteConfirmation =>
      this == MaterialListStatus.deleteConfirmation;
  bool get isDeleted => this == MaterialListStatus.deleted;
}

@immutable
final class MaterialXState extends Equatable {
  const MaterialXState({
    this.status = MaterialListStatus.loading,
    this.message = '',
    this.materials = const <MaterialModel>[],
    this.filter = const <MaterialModel>[],
    this.selectedDeleteRowId = '',
  });

  final MaterialListStatus status;
  final String message;
  final List<MaterialModel> materials;
  final List<MaterialModel> filter;
  final String selectedDeleteRowId;

  MaterialXState copyWith({
    MaterialListStatus? status,
    String? message,
    List<MaterialModel>? materials,
    List<MaterialModel>? filter,
    String? selectedDeleteRowId,
  }) {
    return MaterialXState(
      status: status ?? this.status,
      message: message ?? this.message,
      materials: materials ?? this.materials,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        materials,
        filter,
        selectedDeleteRowId,
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
