part of 'material_list_bloc.dart';

@immutable
sealed class MaterialEvent extends Equatable {
  const MaterialEvent();
}

final class MaterialStarted extends MaterialEvent {
  const MaterialStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}

final class MaterialPageSizeChanged extends MaterialEvent {
  const MaterialPageSizeChanged(this.pageSize);

  final int pageSize;

  @override
  List<Object> get props => [pageSize];
}
