part of 'daybook_detail_form_bloc.dart';

enum DaybookDetailFormStatus {
  loading,
  success,
  failure,
  submitConfirmation,
  submited,
}

extension DaybookDetailFormStatusX on DaybookDetailFormStatus {
  bool get isLoading => this == DaybookDetailFormStatus.loading;
  bool get isSuccess => this == DaybookDetailFormStatus.success;
  bool get isFailure => this == DaybookDetailFormStatus.failure;
  bool get isSubmitConfirmation =>
      this == DaybookDetailFormStatus.submitConfirmation;
  bool get isSubmited => this == DaybookDetailFormStatus.submited;
}

final class DaybookDetailFormState extends Equatable {
  const DaybookDetailFormState({
    this.msAccount = const <MsAccount>[],
    this.msAccountType = const <String>[],
    this.status = DaybookDetailFormStatus.loading,
    this.message = '',
    this.typeName = '',
    this.accountName = '',
    this.id = const Id.pure(),
    this.name = const Name.pure(),
    this.detail = const Detail.pure(),
    this.type = const Type.pure(),
    this.amount = const Amount.pure(),
    this.account = const Account.pure(),
    this.daybook = const Daybook.pure(),
    this.company = const Company.pure(),
    this.isValid = false,
    this.isHistory = false,
  });

  final List<MsAccount> msAccount;
  final List<String> msAccountType;
  final DaybookDetailFormStatus status;
  final String message;
  final String typeName;
  final String accountName;
  final Id id;
  final Name name;
  final Detail detail;
  final Type type;
  final Amount amount;
  final Account account;
  final Daybook daybook;
  final Company company;
  final bool isValid;
  final bool isHistory;

  DaybookDetailFormState copyWith({
    List<MsAccount>? msAccount,
    List<String>? msAccountType,
    DaybookDetailFormStatus? status,
    String? message,
    String? typeName,
    String? accountName,
    Id? id,
    Name? name,
    Detail? detail,
    Type? type,
    Amount? amount,
    Account? account,
    Daybook? daybook,
    Company? company,
    bool? isValid,
    bool? isHistory,
  }) {
    return DaybookDetailFormState(
      msAccount: msAccount ?? this.msAccount,
      msAccountType: msAccountType ?? this.msAccountType,
      status: status ?? this.status,
      message: message ?? this.message,
      typeName: typeName ?? this.typeName,
      accountName: accountName ?? this.accountName,
      id: id ?? this.id,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      account: account ?? this.account,
      daybook: daybook ?? this.daybook,
      company: company ?? this.company,
      isValid: isValid ?? this.isValid,
      isHistory: isHistory ?? this.isHistory,
    );
  }

  @override
  List<Object> get props => [
        status,
        id,
        name,
        detail,
        type,
        amount,
        account,
        daybook,
        company,
        isValid,
        isHistory,
      ];
}

final class DaybookDetailFormLoading extends DaybookDetailFormState {
  @override
  List<Object> get props => [];
}

final class DaybookDetailFormError extends DaybookDetailFormState {
  @override
  List<Object> get props => [];
}
