part of 'material_list_bloc.dart';

@immutable
final class MaterialXState extends Equatable {
  const MaterialXState({
    this.materials = const <MaterialModel>[],
    this.pageSize = 10,
  });

  final List<MaterialModel> materials;
  final int pageSize;

  MaterialXState copyWith({
    int? pageSize,
  }) {
    return MaterialXState(
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [pageSize];
}

final class MaterialLoading extends MaterialXState {
  @override
  List<Object> get props => [];
}

final class MaterialError extends MaterialXState {
  @override
  List<Object> get props => [];
}
