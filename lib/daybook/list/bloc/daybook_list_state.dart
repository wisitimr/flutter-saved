part of 'daybook_list_bloc.dart';

enum DaybookListStatus {
  loading,
  success,
  failure,
  downloaded,
  deleteConfirmation,
  deleted,
}

extension DaybookListStatusX on DaybookListStatus {
  bool get isLoading => this == DaybookListStatus.loading;
  bool get isSuccess => this == DaybookListStatus.success;
  bool get isDownloaded => this == DaybookListStatus.downloaded;
  bool get isFailure => this == DaybookListStatus.failure;
  bool get isDeleteConfirmation => this == DaybookListStatus.deleteConfirmation;
  bool get isDeleted => this == DaybookListStatus.deleted;
}

@immutable
final class DaybookListState extends Equatable {
  const DaybookListState({
    this.status = DaybookListStatus.loading,
    this.message = '',
    this.daybooks = const <DaybookListModel>[],
    this.filter = const <DaybookListModel>[],
    this.selectedDeleteRowId = '',
    this.isHistory = false,
    this.years = const <String>[],
    this.yearSelected = '',
  });

  final List<DaybookListModel> daybooks;
  final List<DaybookListModel> filter;
  final DaybookListStatus status;
  final String message;
  final String selectedDeleteRowId;
  final bool isHistory;
  final List<String> years;
  final String yearSelected;

  DaybookListState copyWith({
    DaybookListStatus? status,
    String? message,
    List<DaybookListModel>? daybooks,
    List<DaybookListModel>? filter,
    String? selectedDeleteRowId,
    bool? isHistory,
    List<String>? years,
    String? yearSelected,
  }) {
    return DaybookListState(
      status: status ?? this.status,
      message: message ?? this.message,
      daybooks: daybooks ?? this.daybooks,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
      isHistory: isHistory ?? this.isHistory,
      years: years ?? this.years,
      yearSelected: yearSelected ?? this.yearSelected,
    );
  }

  @override
  List<Object> get props => [
        message,
        status,
        daybooks,
        filter,
        selectedDeleteRowId,
        isHistory,
        years,
        yearSelected,
      ];
}

final class DaybookListLoading extends DaybookListState {
  @override
  List<Object> get props => [];
}

final class DaybookListError extends DaybookListState {
  @override
  List<Object> get props => [];
}
