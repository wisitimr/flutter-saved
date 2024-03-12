import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findigitalservice/report/ledger_account/list/bloc/report_ledger_account_list_bloc.dart';
import 'package:findigitalservice/report/ledger_account/list/models/account_detail.dart';
import 'package:findigitalservice/report/ledger_account/list/models/report_ledger_account_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/theme/theme_extensions/app_button_theme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_data_table_theme.dart';
import 'package:findigitalservice/widgets/card_elements.dart';
import 'package:findigitalservice/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class ReportLedgerAccountListPage extends StatefulWidget {
  final String year;

  const ReportLedgerAccountListPage({
    Key? key,
    required this.year,
  }) : super(key: key);

  @override
  State<ReportLedgerAccountListPage> createState() =>
      _ReportLedgerAccountListPageState();
}

class _ReportLedgerAccountListPageState
    extends State<ReportLedgerAccountListPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return ReportLedgerAccountListBloc(provider)
            ..add(ReportLedgerAccountListStarted(
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
              child: BlocListener<ReportLedgerAccountListBloc,
                  ReportLedgerAccountListState>(
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
                  } else if (state.status.isShowDialog) {
                    ReportLedgerAccountListModel ledger = state.ledger;
                    final dialog = AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      // title: ledger.code,
                      // desc: ledger.name,
                      body: PreviewLedgerAccount(data: ledger),
                      width: kDialogWidth * 2.5,
                      btnOkText: lang.ok,
                      btnCancelText: lang.close,
                      btnCancelColor: appColorScheme.secondary,
                      btnCancelOnPress: () {},
                    );

                    dialog.show();
                    // showDialog(builder: )
                  }
                },
                child: BlocBuilder<ReportLedgerAccountListBloc,
                    ReportLedgerAccountListState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ReportLedgerAccountListStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case ReportLedgerAccountListStatus.failure:
                        return const ReportLedgerAccountList();
                      case ReportLedgerAccountListStatus.downloaded:
                        return const ReportLedgerAccountList();
                      case ReportLedgerAccountListStatus.dialogShow:
                        return const ReportLedgerAccountList();
                      case ReportLedgerAccountListStatus.success:
                        return const ReportLedgerAccountList();
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

class ReportLedgerAccountList extends StatelessWidget {
  const ReportLedgerAccountList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final dataTableHorizontalScrollController = ScrollController();
    final tKey = GlobalKey<PaginatedDataTableState>();
    final fieldText = TextEditingController();

    Color borderColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        borderColor = Colors.grey.shade700;
      case Brightness.dark:
        borderColor = Colors.white70;
    }

    return BlocBuilder<ReportLedgerAccountListBloc,
        ReportLedgerAccountListState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(title: lang.financialStatement),
              CardBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: kDropdownWidth * 0.5,
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
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
                                onChanged: (year) => {
                                  context
                                      .read<ReportLedgerAccountListBloc>()
                                      .add(ReportLedgerAccountListYearSelected(
                                          year!)),
                                  tKey.currentState?.pageTo(0)
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
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
                              controller: fieldText,
                              decoration: InputDecoration(
                                // labelText: lang.search,
                                hintText: lang.search,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: const Icon(Icons.search),
                              ),
                              onChanged: (text) => {
                                context.read<ReportLedgerAccountListBloc>().add(
                                    ReportLedgerAccountListSearchChanged(text)),
                                tKey.currentState?.pageTo(0)
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (state.count > 0) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: themeData
                                  .extension<AppButtonTheme>()!
                                  .successElevated,
                              onPressed: () => context
                                  .read<ReportLedgerAccountListBloc>()
                                  .add(ReportLedgerAccountListDownload(
                                      state.year)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: kDefaultPadding * 0.5),
                                    child: Icon(
                                      Icons.file_download,
                                      size: (themeData
                                              .textTheme.labelLarge!.fontSize! +
                                          4.0),
                                    ),
                                  ),
                                  Text(lang.download),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ContainedTabBarView(
                        onChange: (value) => {
                          fieldText.clear(),
                          context.read<ReportLedgerAccountListBloc>().add(
                              const ReportLedgerAccountListSearchChanged("")),
                          tKey.currentState?.pageTo(0),
                        },
                        tabBarProperties: const TabBarProperties(
                          width: 300,
                          height: 60,
                          alignment: TabBarAlignment.start,
                        ),
                        tabs: [
                          Text(
                            lang.ledgerAccount,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            lang.tb12,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                        views: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: kDefaultPadding * 2.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final double dataTableWidth = max(
                                            kScreenWidthMd,
                                            constraints.maxWidth);

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
                                                    cardTheme: appDataTableTheme
                                                        .cardTheme,
                                                    dataTableTheme:
                                                        appDataTableTheme
                                                            .dataTableThemeData,
                                                  ),
                                                  child: PaginatedDataTable(
                                                    key: tKey,
                                                    showFirstLastButtons: true,
                                                    columns: [
                                                      DataColumn(
                                                          label:
                                                              Text(lang.code)),
                                                      DataColumn(
                                                          label:
                                                              Text(lang.name)),
                                                      const DataColumn(
                                                          label: Center(
                                                        child: Text(
                                                          '...',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                    ],
                                                    source: _DataSource(
                                                      data: state.ledgetFilter,
                                                      context: context,
                                                      onDetailButtonPressed:
                                                          (data) => context
                                                              .read<
                                                                  ReportLedgerAccountListBloc>()
                                                              .add(ReportLedgerAccountListPreviewLedgerAccount(
                                                                  data.code)),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container()
                        ],
                      ),
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
  final List<ReportLedgerAccountListModel> data;
  final BuildContext context;
  final void Function(ReportLedgerAccountListModel data) onDetailButtonPressed;

  _DataSource({
    required this.data,
    required this.context,
    required this.onDetailButtonPressed,
  });
  final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
  final outputFormat = DateFormat('dd/MM/yyyy');

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    ReportLedgerAccountListModel row = data[index];
    return DataRow(
      cells: [
        DataCell(Text(row.code)),
        DataCell(Text(row.name)),
        DataCell(Builder(
          builder: (context) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.remove_red_eye_rounded),
                    onPressed: () => onDetailButtonPressed.call(row),
                    style: Theme.of(context)
                        .extension<AppButtonTheme>()!
                        .primaryOutlined,
                    label: Text(Lang.of(context).preview),
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

class PreviewLedgerAccount extends StatelessWidget {
  final ReportLedgerAccountListModel data;

  const PreviewLedgerAccount({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final dataTableHorizontalScrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: Row(
              mainAxisAlignment:
                  MediaQuery.of(context).size.width > kScreenWidthSm
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
              children: [
                if (MediaQuery.of(context).size.width > kScreenWidthSm) ...[
                  Text(
                    data.name,
                    style: themeData.textTheme.headlineMedium,
                  ),
                ],
                Text(
                  "${lang.number} ${data.code}",
                  style: themeData.textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding * 2.0),
            child: SizedBox(
              width: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double dataTableWidth =
                      max(kScreenWidthMd, constraints.maxWidth);

                  return Scrollbar(
                    controller: dataTableHorizontalScrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: dataTableHorizontalScrollController,
                      child: SizedBox(
                        width: dataTableWidth,
                        child: Theme(
                            data: themeData.copyWith(
                              cardTheme: appDataTableTheme.cardTheme,
                              dataTableTheme:
                                  appDataTableTheme.dataTableThemeData,
                            ),
                            child: PaginatedDataTable(
                              key: key,
                              showFirstLastButtons: true,
                              columns: [
                                DataColumn(
                                  label: Text(lang.month),
                                ),
                                DataColumn(
                                  label: Text(lang.date),
                                ),
                                DataColumn(
                                  label: Text(lang.detail),
                                ),
                                DataColumn(
                                  label: Text(lang.number),
                                ),
                                DataColumn(
                                    label: Text(
                                  lang.debit,
                                  textAlign: TextAlign.right,
                                )),
                                DataColumn(
                                    label: Text(
                                  lang.credit,
                                  textAlign: TextAlign.right,
                                )),
                                DataColumn(
                                    label: Text(
                                  lang.balance,
                                  textAlign: TextAlign.right,
                                )),
                              ],
                              source: _LedgerAccountDataSource(
                                data: data.accountDetail,
                                context: context,
                                onDetailButtonPressed: (data) {},
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
    );
  }
}

class _LedgerAccountDataSource extends DataTableSource {
  final List<AccountDetail> data;
  final BuildContext context;
  final void Function(AccountDetail data) onDetailButtonPressed;

  _LedgerAccountDataSource({
    required this.data,
    required this.context,
    required this.onDetailButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    AccountDetail row = data[index];
    String dabit = "";
    String credit = "";
    double balance = 0;
    if (row.amountDr > 0) {
      dabit = row.amountDr.toStringAsFixed(2);
    }
    if (row.amountCr > 0) {
      credit = row.amountCr.toStringAsFixed(2);
    }
    if (row.detail != "") {
      if (index == 0) {
        balance = row.amountDr - row.amountCr;
      } else {
        AccountDetail previousRow = data[index - 1];
        balance = (previousRow.amountDr - previousRow.amountCr) +
            row.amountDr -
            row.amountCr;
      }
    }
    return DataRow(
      cells: [
        DataCell(Text(row.month)),
        DataCell(Text(row.date > 0 ? row.date.toString() : '')),
        DataCell(Text(row.detail)),
        DataCell(Text(row.number)),
        DataCell(Align(alignment: Alignment.centerRight, child: Text(dabit))),
        DataCell(Align(alignment: Alignment.centerRight, child: Text(credit))),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text(balance != 0 ? balance.toStringAsFixed(2) : ''))),
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
