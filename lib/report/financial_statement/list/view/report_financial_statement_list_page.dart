import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findigitalservice/report/financial_statement/list/bloc/report_financial_statement_list_bloc.dart';
import 'package:findigitalservice/report/financial_statement/list/models/report_financial_statement_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/theme/theme_extensions/app_button_theme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_data_table_theme.dart';
import 'package:findigitalservice/widgets/card_elements.dart';
import 'package:findigitalservice/widgets/portal_master_layout/portal_master_layout.dart';

class FinancialStatementListPage extends StatefulWidget {
  final String year;

  const FinancialStatementListPage({
    Key? key,
    required this.year,
  }) : super(key: key);

  @override
  State<FinancialStatementListPage> createState() =>
      _FinancialStatementListPageState();
}

class _FinancialStatementListPageState
    extends State<FinancialStatementListPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return FinancialStatementListBloc(provider)
            ..add(FinancialStatementListStarted(
              widget.year.isNotEmpty ? int.parse(widget.year) : 0,
            ));
        },
        child: ListView(
          padding: const EdgeInsets.all(kDefaultPadding),
          children: [
            Text(
              provider.companyName,
              style: themeData.textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: BlocListener<FinancialStatementListBloc,
                  FinancialStatementListState>(
                listener: (context, state) {
                  // print(state.status);
                  if (state.status.isFailure) {
                    final dialog = AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      desc: state.message,
                      width: kDialogWidth,
                      btnOkText: lang.ok,
                      btnOkOnPress: () {},
                    );

                    dialog.show();
                  } else if (state.status.isDeleteConfirmation) {
                    final dialog = AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      desc: lang.confirmDeleteRecord,
                      width: kDialogWidth,
                      btnOkText: lang.ok,
                      btnOkColor: appColorScheme.error,
                      btnOkOnPress: () {
                        context
                            .read<FinancialStatementListBloc>()
                            .add(const FinancialStatementListDelete());
                      },
                      btnCancelText: lang.cancel,
                      btnCancelColor: appColorScheme.secondary,
                      btnCancelOnPress: () {},
                    );

                    dialog.show();
                  } else if (state.status.isDeleted) {
                    final dialog = AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      desc: state.message,
                      width: kDialogWidth,
                      btnOkText: lang.ok,
                      btnOkOnPress: () async {
                        context
                            .read<FinancialStatementListBloc>()
                            .add(FinancialStatementListStarted(state.year));
                      },
                    );

                    dialog.show();
                  } else if (state.status.isDeleted) {
                    final dialog = AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      desc: state.message,
                      width: kDialogWidth,
                      btnOkText: lang.ok,
                      btnOkOnPress: () async {
                        context
                            .read<FinancialStatementListBloc>()
                            .add(FinancialStatementListStarted(state.year));
                      },
                    );

                    dialog.show();
                  }
                },
                child: BlocBuilder<FinancialStatementListBloc,
                    FinancialStatementListState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case FinancialStatementListStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case FinancialStatementListStatus.failure:
                        return const FinancialStatementList();
                      case FinancialStatementListStatus.downloaded:
                        return const FinancialStatementList();
                      case FinancialStatementListStatus.deleteConfirmation:
                        return const FinancialStatementList();
                      case FinancialStatementListStatus.deleted:
                        return const FinancialStatementList();
                      case FinancialStatementListStatus.success:
                        return const FinancialStatementList();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinancialStatementList extends StatelessWidget {
  const FinancialStatementList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final dataTableHorizontalScrollController = ScrollController();
    final key = GlobalKey<PaginatedDataTableState>();
    Color borderColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        borderColor = Colors.grey.shade700;
      case Brightness.dark:
        borderColor = Colors.white70;
    }

    return BlocBuilder<FinancialStatementListBloc, FinancialStatementListState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: lang.ledgerAccount,
              ),
              CardBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: kDefaultPadding),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: kTextPadding,
                        runSpacing: kTextPadding,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: kDropdownWidth * 0.5,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      bottomLeft: Radius.circular(4.0),
                                    ),
                                    border: Border(
                                      left: BorderSide(
                                        color: borderColor,
                                      ),
                                      top: BorderSide(
                                        color: borderColor,
                                      ),
                                      bottom: BorderSide(
                                        color: borderColor,
                                      ),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      items: state.yearList
                                          .map((year) => DropdownMenuItem(
                                                value: year,
                                                child: Text(
                                                  year.toString(),
                                                  style: const TextStyle(),
                                                ),
                                              ))
                                          .toList(),
                                      value: state.year,
                                      onChanged: (year) => context
                                          .read<FinancialStatementListBloc>()
                                          .add(
                                              FinancialStatementListYearSelected(
                                                  year!)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(4.0),
                                      bottomRight: Radius.circular(4.0),
                                    ),
                                    border: Border(
                                      left: BorderSide(
                                        color: borderColor,
                                      ),
                                      top: BorderSide(
                                        color: borderColor,
                                      ),
                                      bottom: BorderSide(
                                        color: borderColor,
                                      ),
                                      right: BorderSide(
                                        color: borderColor,
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      // labelText: lang.search,
                                      hintText: lang.search,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      suffixIcon: const Icon(Icons.search),
                                    ),
                                    onChanged: (text) => {
                                      context
                                          .read<FinancialStatementListBloc>()
                                          .add(
                                              FinancialStatementListSearchChanged(
                                                  text)),
                                      key.currentState?.pageTo(0)
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    if (!state.isHistory) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 0.5),
                            child: SizedBox(
                              height: 40.0,
                              child: ElevatedButton(
                                style: themeData
                                    .extension<AppButtonTheme>()!
                                    .successElevated,
                                onPressed: () {
                                  GoRouter.of(context)
                                      .go('${RouteUri.daybookForm}?isNew=true');
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: kDefaultPadding * 0.5),
                                      child: Icon(
                                        Icons.add,
                                        size: (themeData.textTheme.labelLarge!
                                                .fontSize! +
                                            4.0),
                                      ),
                                    ),
                                    Text(lang.crudNew),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: kDefaultPadding * 2.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final double dataTableWidth =
                                    max(kScreenWidthMd, constraints.maxWidth);

                                return Scrollbar(
                                  controller:
                                      dataTableHorizontalScrollController,
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller:
                                        dataTableHorizontalScrollController,
                                    child: SizedBox(
                                      width: dataTableWidth,
                                      child: Theme(
                                          data: themeData.copyWith(
                                            cardTheme:
                                                appDataTableTheme.cardTheme,
                                            dataTableTheme: appDataTableTheme
                                                .dataTableThemeData,
                                          ),
                                          child: PaginatedDataTable(
                                            key: key,
                                            showFirstLastButtons: true,
                                            columns: [
                                              DataColumn(
                                                  label: Text(lang.number)),
                                              DataColumn(
                                                  label: Text(lang.invoice)),
                                              DataColumn(
                                                  label: Text(lang.document)),
                                              DataColumn(
                                                  label: Text(
                                                      lang.transactionDate)),
                                              const DataColumn(
                                                  label: Center(
                                                child: Text(
                                                  '...',
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                            ],
                                            source: _DataSource(
                                              data: state.filter,
                                              context: context,
                                              onDownloadButtonPressed: (year) => context
                                                  .read<
                                                      FinancialStatementListBloc>()
                                                  .add(
                                                      FinancialStatementListDownload(
                                                          year)),
                                              onDetailButtonPressed: (data) =>
                                                  GoRouter.of(context).go(
                                                      '${RouteUri.daybookForm}?id=${data.id}&isHistory=${state.isHistory}&year=${state.year}'),
                                            ),
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchForm {
  String company = '';
  String code = '';
  String number = '';
  String type = '';
}

class _DataSource extends DataTableSource {
  final List<FinancialStatementListModel> data;
  final BuildContext context;
  final void Function(FinancialStatementListModel data) onDownloadButtonPressed;
  final void Function(FinancialStatementListModel data) onDetailButtonPressed;

  _DataSource({
    required this.data,
    required this.context,
    required this.onDownloadButtonPressed,
    required this.onDetailButtonPressed,
  });
  final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
  final outputFormat = DateFormat('dd/MM/yyyy');

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    FinancialStatementListModel row = data[index];
    var createdAt = inputFormat.parse(row.transactionDate);
    return DataRow(
      cells: [
        DataCell(Text(row.number)),
        DataCell(Text(row.invoice)),
        DataCell(Text(row.document)),
        DataCell(Text(outputFormat.format(createdAt))),
        DataCell(Builder(
          builder: (context) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.file_download),
                    onPressed: () => onDownloadButtonPressed.call(row),
                    style: Theme.of(context)
                        .extension<AppButtonTheme>()!
                        .successOutlined,
                    label: Text(Lang.of(context).download),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit_document),
                    onPressed: () => onDetailButtonPressed.call(row),
                    style: Theme.of(context)
                        .extension<AppButtonTheme>()!
                        .primaryOutlined,
                    label: Text(Lang.of(context).crudDetail),
                  ),
                ),
              ],
            );
          },
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
