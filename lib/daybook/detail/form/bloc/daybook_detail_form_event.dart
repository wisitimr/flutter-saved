part of 'daybook_detail_form_bloc.dart';

@immutable
sealed class DaybookDetailFormEvent extends Equatable {
  const DaybookDetailFormEvent();

  @override
  List<Object> get props => [];
}

final class DaybookDetailFormStarted extends DaybookDetailFormEvent {
  const DaybookDetailFormStarted(this.id, this.daybook, this.isHistory);

  final String id;
  final String daybook;
  final bool isHistory;

  @override
  List<Object> get props => [
        id,
        daybook,
        isHistory,
      ];
}

final class DaybookDetailFormIdChanged extends DaybookDetailFormEvent {
  const DaybookDetailFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class DaybookDetailFormNameChanged extends DaybookDetailFormEvent {
  const DaybookDetailFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class DaybookDetailFormTypeChanged extends DaybookDetailFormEvent {
  const DaybookDetailFormTypeChanged(this.type);

  final String type;

  @override
  List<Object> get props => [type];
}

final class DaybookDetailFormAmountChanged extends DaybookDetailFormEvent {
  const DaybookDetailFormAmountChanged(this.amount);

  final String amount;

  @override
  List<Object> get props => [amount];
}

final class DaybookDetailFormAccountChanged extends DaybookDetailFormEvent {
  const DaybookDetailFormAccountChanged(this.account);

  final String account;

  @override
  List<Object> get props => [account];
}

final class DaybookDetailFormSubmitConfirm extends DaybookDetailFormEvent {
  const DaybookDetailFormSubmitConfirm();

  @override
  List<Object> get props => [];
}

final class DaybookDetailSubmitted extends DaybookDetailFormEvent {
  const DaybookDetailSubmitted();

  @override
  List<Object> get props => [];
}
