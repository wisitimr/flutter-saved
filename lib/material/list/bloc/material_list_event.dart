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

final class MaterialSearchChanged extends MaterialEvent {
  const MaterialSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
