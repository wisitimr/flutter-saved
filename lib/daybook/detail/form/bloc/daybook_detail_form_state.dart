part of 'daybook_detail_form_bloc.dart';

final class DaybookDetailFormState extends Equatable {
  const DaybookDetailFormState({
    this.isLoading = true,
    this.msAccount = const <MsAccount>[],
    this.msAccountType = const <String>[],
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.id = const Id.pure(),
    this.name = const Name.pure(),
    this.type = const Type.pure(),
    this.amount = const Amount.pure(),
    this.account = const Account.pure(),
    this.daybook = const Daybook.pure(),
    this.isValid = false,
  });

  final bool isLoading;
  final List<MsAccount> msAccount;
  final List<String> msAccountType;
  final FormzSubmissionStatus status;
  final String message;
  final Id id;
  final Name name;
  final Type type;
  final Amount amount;
  final Account account;
  final Daybook daybook;
  final bool isValid;

  DaybookDetailFormState copyWith({
    bool? isLoading,
    List<MsAccount>? msAccount,
    List<String>? msAccountType,
    FormzSubmissionStatus? status,
    String? message,
    Id? id,
    Name? name,
    Type? type,
    Amount? amount,
    Account? account,
    Daybook? daybook,
    bool? isValid,
  }) {
    return DaybookDetailFormState(
      isLoading: isLoading ?? this.isLoading,
      msAccount: msAccount ?? this.msAccount,
      msAccountType: msAccountType ?? this.msAccountType,
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      account: account ?? this.account,
      daybook: daybook ?? this.daybook,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, status, id, name, type, amount, account, daybook, isValid];
}

final class DaybookDetailFormLoading extends DaybookDetailFormState {
  @override
  List<Object> get props => [];
}

final class DaybookDetailFormError extends DaybookDetailFormState {
  @override
  List<Object> get props => [];
}
