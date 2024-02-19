part of 'material_list_bloc.dart';

enum Status { loading, success, failure }

@immutable
final class MaterialXState extends Equatable {
  const MaterialXState({
    this.status = Status.loading,
    this.message = '',
    this.materials = const <MaterialModel>[],
    this.filter = const <MaterialModel>[],
  });

  final Status status;
  final String message;
  final List<MaterialModel> materials;
  final List<MaterialModel> filter;

  MaterialXState copyWith({
    Status? status,
    String? message,
    List<MaterialModel>? materials,
    List<MaterialModel>? filter,
  }) {
    return MaterialXState(
      status: status ?? this.status,
      message: message ?? this.message,
      materials: materials ?? this.materials,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [status, message, materials, filter];
}

final class MaterialLoading extends MaterialXState {
  @override
  List<Object> get props => [];
}

final class MaterialError extends MaterialXState {
  @override
  List<Object> get props => [];
}
