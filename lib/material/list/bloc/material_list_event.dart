part of 'material_list_bloc.dart';

@immutable
sealed class MaterialEvent extends Equatable {
  const MaterialEvent();
}

final class MaterialStarted extends MaterialEvent {
  const MaterialStarted();

  @override
  List<Object> get props => [];
}

final class MaterialSearchChanged extends MaterialEvent {
  const MaterialSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class MaterialDeleteConfirm extends MaterialEvent {
  const MaterialDeleteConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class MaterialDelete extends MaterialEvent {
  const MaterialDelete();

  @override
  List<Object> get props => [];
}
