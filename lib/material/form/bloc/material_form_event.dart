part of 'material_form_bloc.dart';

@immutable
sealed class MaterialFormEvent extends Equatable {
  const MaterialFormEvent();

  @override
  List<Object> get props => [];
}

final class MaterialFormStarted extends MaterialFormEvent {
  const MaterialFormStarted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class MaterialFormIdChanged extends MaterialFormEvent {
  const MaterialFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class MaterialFormCodeChanged extends MaterialFormEvent {
  const MaterialFormCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class MaterialFormNameChanged extends MaterialFormEvent {
  const MaterialFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class MaterialFormDescriptionChanged extends MaterialFormEvent {
  const MaterialFormDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class MaterialFormSubmitConfirm extends MaterialFormEvent {
  const MaterialFormSubmitConfirm();

  @override
  List<Object> get props => [];
}

final class MaterialSubmitted extends MaterialFormEvent {
  const MaterialSubmitted();

  @override
  List<Object> get props => [];
}
