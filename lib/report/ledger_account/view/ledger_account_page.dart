import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findigitalservice/report/ledger_account/bloc/ledger_account_bloc.dart';
import 'package:findigitalservice/report/ledger_account/models/models.dart';
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

class ReportLedgerAccountPage extends StatefulWidget {
  final String year;

  const ReportLedgerAccountPage({
    Key? key,
    required this.year,
  }) : super(key: key);

  @override
  State<ReportLedgerAccountPage> createState() =>
      _ReportLedgerAccountPageState();
}

class _ReportLedgerAccountPageState extends State<ReportLedgerAccountPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return ReportLedgerAccountBloc(provider)
            ..add(ReportLedgerAccountStarted(
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
              child: BlocListener<ReportLedgerAccountBloc,
                  ReportLedgerAccountState>(
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
                  } else if (state.status.isShowLedgerDialog) {
                    ReportLedgerAccountModel ledger = state.ledger;
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
                child: BlocBuilder<ReportLedgerAccountBloc,
                    ReportLedgerAccountState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ReportLedgerAccountStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case ReportLedgerAccountStatus.failure:
                        return const ReportLedgerAccount();
                      case ReportLedgerAccountStatus.downloaded:
                        return const ReportLedgerAccount();
                      case ReportLedgerAccountStatus.ledgerDialog:
                        return const ReportLedgerAccount();
                      case ReportLedgerAccountStatus.success:
                        return const ReportLedgerAccount();
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

class ReportLedgerAccount extends StatelessWidget {
  const ReportLedgerAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final dataTableHorizontalScrollController = ScrollController();
    final tableKey1 = GlobalKey<PaginatedDataTableState>();
    final fieldText = TextEditingController();

    // Color tabColor;
    Color borderColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        borderColor = Colors.grey.shade700;
      // tabColor = Colors.black12;
      case Brightness.dark:
        borderColor = Colors.white70;
      // tabColor = Colors.white12;
    }
    return BlocBuilder<ReportLedgerAccountBloc, ReportLedgerAccountState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(title: lang.ledgerAccount),
              CardBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: kDropdownWidth * 0.5,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
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
                                    context.read<ReportLedgerAccountBloc>().add(
                                        ReportLedgerAccountYearSelected(year!)),
                                    tableKey1.currentState?.pageTo(0)
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
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
                                  context.read<ReportLedgerAccountBloc>().add(
                                      ReportLedgerAccountSearchChanged(text)),
                                  tableKey1.currentState?.pageTo(0)
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.count > 0) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: themeData
                              .extension<AppButtonTheme>()!
                              .successElevated,
                          onPressed: () => context
                              .read<ReportLedgerAccountBloc>()
                              .add(ReportLedgerAccountDownload(state.year)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding * 0.5),
                                  child: Icon(
                                    Icons.file_download,
                                    size: (themeData
                                            .textTheme.labelLarge!.fontSize! +
                                        4.0),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(lang.download)),
                            ],
                          ),
                        ),
                      ),
                    ],
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height < 700
                          ? 700 * 2
                          : MediaQuery.of(context).size.height * 1.2,
                      child: Column(
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
                                        kScreenWidthMd, constraints.maxWidth);

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
                                                dataTableTheme:
                                                    appDataTableTheme
                                                        .dataTableThemeData,
                                              ),
                                              child: PaginatedDataTable(
                                                key: tableKey1,
                                                showFirstLastButtons: true,
                                                columns: [
                                                  DataColumn(
                                                      label: Text(lang.code)),
                                                  DataColumn(
                                                      label: Text(lang.name)),
                                                  const DataColumn(
                                                      label: Text('...')),
                                                ],
                                                source: _DataSource(
                                                  data: state.ledgetFilter,
                                                  context: context,
                                                  onDetailButtonPressed:
                                                      (data) => context
                                                          .read<
                                                              ReportLedgerAccountBloc>()
                                                          .add(
                                                              ReportLedgerAccountPreviewLedgerAccount(
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
  final List<ReportLedgerAccountModel> data;
  final BuildContext context;
  final void Function(ReportLedgerAccountModel data) onDetailButtonPressed;

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

    ReportLedgerAccountModel row = data[index];
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
  final ReportLedgerAccountModel data;

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
    final oCcy = NumberFormat("#,##0.00", "en_US");

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
                            child: DataTable(
                              key: key,
                              // rowsPerPage: data.accountDetail.length > 10
                              //     ? 10
                              //     : data.accountDetail.length,
                              // showFirstLastButtons: true,
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
                                  label: Text(lang.folio),
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
                              rows: List.generate(
                                data.accountDetail.length,
                                (index) {
                                  AccountDetail row = data.accountDetail[index];

                                  double balance = 0;
                                  if (index == 0 || row.detail == "รวม") {
                                    balance = row.amountDr - row.amountCr;
                                  } else {
                                    if (row.date > 0) {
                                      double preBalance = 0;
                                      for (var i = 0; i < index; i++) {
                                        AccountDetail p = data.accountDetail[i];
                                        if (i == 0) {
                                          preBalance =
                                              (p.amountDr - p.amountCr);
                                        } else {
                                          preBalance = (preBalance +
                                              p.amountDr -
                                              p.amountCr);
                                        }
                                      }
                                      balance = preBalance +
                                          row.amountDr -
                                          row.amountCr;
                                    }
                                  }
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(index > 0 &&
                                              data.accountDetail[index - 1]
                                                      .month ==
                                                  row.month
                                          ? ""
                                          : row.month)),
                                      DataCell(Text(row.date > 0
                                          ? row.date.toString()
                                          : '')),
                                      DataCell(Text(row.detail)),
                                      DataCell(Text(row.number)),
                                      DataCell(Align(
                                          alignment: Alignment.centerRight,
                                          child:
                                              Text(oCcy.format(row.amountDr)))),
                                      DataCell(Align(
                                          alignment: Alignment.centerRight,
                                          child:
                                              Text(oCcy.format(row.amountCr)))),
                                      DataCell(Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(oCcy.format(balance)))),
                                    ],
                                  );
                                },
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
