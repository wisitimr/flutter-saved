import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findigitalservice/report/financial_statement/list/bloc/report_financial_statement_list_bloc.dart';
import 'package:findigitalservice/report/financial_statement/list/models/models.dart';
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
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ReportFinancialStatementListPage extends StatefulWidget {
  final String year;

  const ReportFinancialStatementListPage({
    Key? key,
    required this.year,
  }) : super(key: key);

  @override
  State<ReportFinancialStatementListPage> createState() =>
      _ReportFinancialStatementListPageState();
}

class _ReportFinancialStatementListPageState
    extends State<ReportFinancialStatementListPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return ReportFinancialStatementListBloc(provider)
            ..add(ReportFinancialStatementListStarted(
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
              child: BlocListener<ReportFinancialStatementListBloc,
                  ReportFinancialStatementListState>(
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
                    ReportFinancialStatementListModel ledger = state.ledger;
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
                  } else if (state.status.isShowAccountBlance) {
                    AccountBalance accountBalance = state.accountBalance;
                    final dialog = AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      // title: ledger.code,
                      // desc: ledger.name,
                      body: PreviewAccountBalance(
                        data: accountBalance,
                        state: state,
                      ),
                      width: kDialogWidth * 5,
                      btnOkText: lang.ok,
                      btnCancelText: lang.close,
                      btnCancelColor: appColorScheme.secondary,
                      btnCancelOnPress: () {},
                    );

                    dialog.show();
                    // showDialog(builder: )
                  }
                },
                child: BlocBuilder<ReportFinancialStatementListBloc,
                    ReportFinancialStatementListState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ReportFinancialStatementListStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case ReportFinancialStatementListStatus.failure:
                        return const ReportFinancialStatementList();
                      case ReportFinancialStatementListStatus.downloaded:
                        return const ReportFinancialStatementList();
                      case ReportFinancialStatementListStatus.ledgerDialog:
                        return const ReportFinancialStatementList();
                      case ReportFinancialStatementListStatus
                            .accountBlanceDialog:
                        return const ReportFinancialStatementList();
                      case ReportFinancialStatementListStatus.success:
                        return const ReportFinancialStatementList();
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

class ReportFinancialStatementList extends StatelessWidget {
  const ReportFinancialStatementList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final dataTableHorizontalScrollController = ScrollController();
    final dataTableHorizontalScrollController2 = ScrollController();
    final tableKey1 = GlobalKey<PaginatedDataTableState>();
    final tableKey2 = GlobalKey<PaginatedDataTableState>();
    final fieldText = TextEditingController();

    Color borderColor;
    Color textColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        borderColor = Colors.grey.shade700;
        textColor = Colors.black;
      case Brightness.dark:
        borderColor = Colors.white70;
        textColor = Colors.white;
    }
    return BlocBuilder<ReportFinancialStatementListBloc,
        ReportFinancialStatementListState>(
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
                                      .read<ReportFinancialStatementListBloc>()
                                      .add(
                                          ReportFinancialStatementListYearSelected(
                                              year!)),
                                  tableKey1.currentState?.pageTo(0)
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
                                context
                                    .read<ReportFinancialStatementListBloc>()
                                    .add(
                                        ReportFinancialStatementListSearchChanged(
                                            text)),
                                tableKey1.currentState?.pageTo(0)
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (state.count > 0) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: themeData
                                  .extension<AppButtonTheme>()!
                                  .successElevated,
                              onPressed: () => context
                                  .read<ReportFinancialStatementListBloc>()
                                  .add(ReportFinancialStatementListDownload(
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
                      height: MediaQuery.of(context).size.height < 700
                          ? 700 * 1.6
                          : MediaQuery.of(context).size.height * 1.2,
                      child: ContainedTabBarView(
                        onChange: (value) => {
                          fieldText.clear(),
                          context.read<ReportFinancialStatementListBloc>().add(
                              const ReportFinancialStatementListSearchChanged(
                                  "")),
                          tableKey1.currentState?.pageTo(0),
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
                                                    key: tableKey1,
                                                    showFirstLastButtons: true,
                                                    columns: [
                                                      DataColumn(
                                                          label:
                                                              Text(lang.code)),
                                                      DataColumn(
                                                          label:
                                                              Text(lang.name)),
                                                      const DataColumn(
                                                          label: Text('...')),
                                                    ],
                                                    source: _DataSource(
                                                      data: state.ledgetFilter,
                                                      context: context,
                                                      onDetailButtonPressed:
                                                          (data) => context
                                                              .read<
                                                                  ReportFinancialStatementListBloc>()
                                                              .add(ReportFinancialStatementListPreviewLedgerAccount(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: kDefaultPadding,
                                  bottom: kDefaultPadding,
                                ),
                                child: MultiSelectDialogField(
                                  // chipBackGroundColor: appColorScheme.success,
                                  // chipLabelStyle: const TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                  // dialogTextStyle: const TextStyle(
                                  //     fontWeight: FontWeight.bold),
                                  // // checkBoxActiveColor: Colors.red,
                                  // // checkBoxCheckColor: Colors.green,
                                  // dialogShapeBorder:
                                  //     const RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(12.0))),
                                  // title: const Text(
                                  //   "Columns",
                                  //   style: TextStyle(fontSize: 16),
                                  // ),
                                  items: const [
                                    {"index": 0, "text": "ยกยอดมา (DR)"},
                                    {"index": 1, "text": "ยกยอดมา (CR)"},
                                    {"index": 2, "text": "มค (DR)"},
                                    {"index": 3, "text": "มค (CR)"},
                                    {"index": 4, "text": "กพ (DR)"},
                                    {"index": 5, "text": "กพ (CR)"},
                                    {"index": 6, "text": "มีค (DR)"},
                                    {"index": 7, "text": "มีค (CR)"},
                                    {"index": 8, "text": "เมย (DR)"},
                                    {"index": 9, "text": "เมย (CR)"},
                                    {"index": 10, "text": "พค (DR)"},
                                    {"index": 11, "text": "พค (CR)"},
                                    {"index": 12, "text": "มิย (DR)"},
                                    {"index": 13, "text": "มิย (CR)"},
                                    {"index": 14, "text": "กค (DR)"},
                                    {"index": 15, "text": "กค (CR)"},
                                    {"index": 16, "text": "สค (DR)"},
                                    {"index": 17, "text": "สค (CR)"},
                                    {"index": 18, "text": "กย (DR)"},
                                    {"index": 19, "text": "กย (CR)"},
                                    {"index": 20, "text": "ตค (DR)"},
                                    {"index": 21, "text": "ตค (CR)"},
                                    {"index": 22, "text": "พศ (DR)"},
                                    {"index": 23, "text": "พศ (CR)"},
                                    {"index": 24, "text": "ธค (DR)"},
                                    {"index": 25, "text": "ธค (CR)"},
                                    {"index": 26, "text": "Total (DR)"},
                                    {"index": 27, "text": "Total (CR)"},
                                    {"index": 28, "text": "Ending"},
                                  ]
                                      .map((e) => MultiSelectItem(
                                          e["index"], e["text"] as String))
                                      .toList(),
                                  initialValue: state.columnSelected,
                                  listType: MultiSelectListType.CHIP,
                                  checkColor: appColorScheme.error,
                                  buttonText:
                                      const Text("Tap to select one or more"),
                                  chipDisplay: MultiSelectChipDisplay(
                                    chipColor: appColorScheme.success,
                                    textStyle: TextStyle(color: textColor),
                                  ),
                                  itemsTextStyle: TextStyle(
                                    color: textColor,
                                  ),
                                  selectedItemsTextStyle: TextStyle(
                                    color: textColor,
                                    backgroundColor: appColorScheme.success,
                                  ),
                                  selectedColor: appColorScheme.success,
                                  title: const Text("Select one or more"),
                                  onConfirm: (value) {
                                    return context
                                        .read<
                                            ReportFinancialStatementListBloc>()
                                        .add(
                                            ReportFinancialStatementListAccountBalanceColumnSelected(
                                                value));
                                  },
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: kDefaultPadding * 2.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final double dataTableWidth = max(
                                            kScreenWidthSm,
                                            constraints.maxWidth);

                                        return Scrollbar(
                                          controller:
                                              dataTableHorizontalScrollController2,
                                          thumbVisibility: true,
                                          trackVisibility: true,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller:
                                                dataTableHorizontalScrollController2,
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
                                                    key: tableKey2,
                                                    // rowsPerPage: 5,
                                                    showFirstLastButtons: false,
                                                    columns: [
                                                      DataColumn(
                                                          label: Text(lang
                                                              .accountGroup)),
                                                      if (state
                                                          .isForwardDrShow) ...[
                                                        const DataColumn(
                                                          label: Text(
                                                              "ยอดยกมา (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isForwardCrShow) ...[
                                                        const DataColumn(
                                                          label: Text(
                                                              "ยอดยกมา (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isJanDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("มค (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isJanCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("มค (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isFebDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("กพ (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isFebCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("กพ (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isMarDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("มีค (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isMarCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("มีค (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isAprDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("เมย (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isAprCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("เมย (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isMayDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("พค (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isMayCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("พค (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isJunDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("มิย (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isJunCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("มิย (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isJulDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("กค (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isJulCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("กค (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isAugDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("สค (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isAugCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("สค (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isSepDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("กย (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isSepCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("กย (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isOctDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("ตค (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isOctCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("ตค (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isNovDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("พศ (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isNovCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("พศ (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isDecDrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("ธค (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isDecCrShow) ...[
                                                        const DataColumn(
                                                          label:
                                                              Text("ธค (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isTotalDrShow) ...[
                                                        const DataColumn(
                                                          label: Text(
                                                              "Total (DR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isTotalCrShow) ...[
                                                        const DataColumn(
                                                          label: Text(
                                                              "Total (CR)"),
                                                        ),
                                                      ],
                                                      if (state
                                                          .isBalanceShow) ...[
                                                        const DataColumn(
                                                          label: Text("Ending"),
                                                        ),
                                                      ],
                                                      const DataColumn(
                                                          label: Text('...')),
                                                    ],
                                                    source:
                                                        AccountBalanceDataSource(
                                                      state: state,
                                                      data:
                                                          state.accountBalances,
                                                      context: context,
                                                      onDetailButtonPressed:
                                                          (data) => context
                                                              .read<
                                                                  ReportFinancialStatementListBloc>()
                                                              .add(ReportFinancialStatementListPreviewAccountBalance(
                                                                  data.accountGroup)),
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
                          // Container(),
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
  final List<ReportFinancialStatementListModel> data;
  final BuildContext context;
  final void Function(ReportFinancialStatementListModel data)
      onDetailButtonPressed;

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

    ReportFinancialStatementListModel row = data[index];
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
  final ReportFinancialStatementListModel data;

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
                              rowsPerPage: data.accountDetail.length > 10
                                  ? 10
                                  : data.accountDetail.length,
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
                              source: LedgerAccountDataSource(
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

class LedgerAccountDataSource extends DataTableSource {
  final List<AccountDetail> data;
  final BuildContext context;
  final void Function(AccountDetail data) onDetailButtonPressed;
  final oCcy = NumberFormat("#,##0.00", "en_US");

  LedgerAccountDataSource({
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
    double balance = 0;
    if (index == 0 || row.detail == "รวม") {
      balance = row.amountDr - row.amountCr;
    } else {
      if (row.date > 0) {
        double preBalance = 0;
        for (var i = 0; i < index; i++) {
          AccountDetail p = data[i];
          if (i == 0) {
            preBalance = (p.amountDr - p.amountCr);
          } else {
            preBalance = (preBalance + p.amountDr - p.amountCr);
          }
        }
        balance = preBalance + row.amountDr - row.amountCr;
      }
    }
    return DataRow(
      cells: [
        DataCell(Text(
            index > 0 && data[index - 1].month == row.month ? "" : row.month)),
        DataCell(Text(row.date > 0 ? row.date.toString() : '')),
        DataCell(Text(row.detail)),
        DataCell(Text(row.number)),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text(oCcy.format(row.amountDr)))),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text(oCcy.format(row.amountCr)))),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text(balance != 0 ? oCcy.format(balance) : ''))),
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

class AccountBalanceDataSource extends DataTableSource {
  final ReportFinancialStatementListState state;
  final List<AccountBalance> data;
  final BuildContext context;
  final void Function(AccountBalance data) onDetailButtonPressed;

  AccountBalanceDataSource({
    required this.state,
    required this.data,
    required this.context,
    required this.onDetailButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    final lang = Lang.of(context);

    if (index >= data.length) {
      return null;
    }

    AccountBalance row = data[index];
    return DataRow(
      cells: [
        DataCell(Text(lang.getAccoutGroup(row.accountGroup))),
        if (state.isForwardDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumForwardDr)))),
        ],
        if (state.isForwardCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumForwardCr)))),
        ],
        if (state.isJanDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumJanDr)))),
        ],
        if (state.isJanCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumJanCr)))),
        ],
        if (state.isFebDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumFebDr)))),
        ],
        if (state.isFebCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumFebCr)))),
        ],
        if (state.isMarDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumMarDr)))),
        ],
        if (state.isMarCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumMarCr)))),
        ],
        if (state.isAprDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumAprDr)))),
        ],
        if (state.isAprCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumAprCr)))),
        ],
        if (state.isMayDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumMayDr)))),
        ],
        if (state.isMayCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumMayCr)))),
        ],
        if (state.isJunDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumJunDr)))),
        ],
        if (state.isJunCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumJunCr)))),
        ],
        if (state.isJulDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumJulDr)))),
        ],
        if (state.isJulCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumJulCr)))),
        ],
        if (state.isAugDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumAugDr)))),
        ],
        if (state.isAugCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumAugCr)))),
        ],
        if (state.isSepDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumSepDr)))),
        ],
        if (state.isSepCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumSepCr)))),
        ],
        if (state.isOctDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumOctDr)))),
        ],
        if (state.isOctCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumOctCr)))),
        ],
        if (state.isNovDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumNovDr)))),
        ],
        if (state.isNovCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumNovCr)))),
        ],
        if (state.isDecDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumDecDr)))),
        ],
        if (state.isDecCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumDecCr)))),
        ],
        if (state.isTotalDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumTotalDr)))),
        ],
        if (state.isTotalCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumTotalCr)))),
        ],
        if (state.isBalanceShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sumBalance)))),
        ],
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

class PreviewAccountBalance extends StatelessWidget {
  final ReportFinancialStatementListState state;
  final AccountBalance data;

  const PreviewAccountBalance({
    Key? key,
    required this.state,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final dataTableHorizontalScrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                            rowsPerPage:
                                data.child.length > 10 ? 10 : data.child.length,
                            showFirstLastButtons: true,
                            columns: [
                              const DataColumn(
                                label: Text("Account No"),
                              ),
                              const DataColumn(
                                label: Text("Account Name"),
                              ),
                              if (state.isForwardDrShow) ...[
                                const DataColumn(
                                  label: Text("ยอดยกมา (DR)"),
                                ),
                              ],
                              if (state.isForwardCrShow) ...[
                                const DataColumn(
                                  label: Text("ยอดยกมา (CR)"),
                                ),
                              ],
                              if (state.isJanDrShow) ...[
                                const DataColumn(
                                  label: Text("มค (DR)"),
                                ),
                              ],
                              if (state.isJanCrShow) ...[
                                const DataColumn(
                                  label: Text("มค (CR)"),
                                ),
                              ],
                              if (state.isFebDrShow) ...[
                                const DataColumn(
                                  label: Text("กพ (DR)"),
                                ),
                              ],
                              if (state.isFebCrShow) ...[
                                const DataColumn(
                                  label: Text("กพ (CR)"),
                                ),
                              ],
                              if (state.isMarDrShow) ...[
                                const DataColumn(
                                  label: Text("มีค (DR)"),
                                ),
                              ],
                              if (state.isMarCrShow) ...[
                                const DataColumn(
                                  label: Text("มีค (CR)"),
                                ),
                              ],
                              if (state.isAprDrShow) ...[
                                const DataColumn(
                                  label: Text("เมย (DR)"),
                                ),
                              ],
                              if (state.isAprCrShow) ...[
                                const DataColumn(
                                  label: Text("เมย (CR)"),
                                ),
                              ],
                              if (state.isMayDrShow) ...[
                                const DataColumn(
                                  label: Text("พค (DR)"),
                                ),
                              ],
                              if (state.isMayCrShow) ...[
                                const DataColumn(
                                  label: Text("พค (CR)"),
                                ),
                              ],
                              if (state.isJunDrShow) ...[
                                const DataColumn(
                                  label: Text("มิย (DR)"),
                                ),
                              ],
                              if (state.isJunCrShow) ...[
                                const DataColumn(
                                  label: Text("มิย (CR)"),
                                ),
                              ],
                              if (state.isJulDrShow) ...[
                                const DataColumn(
                                  label: Text("กค (DR)"),
                                ),
                              ],
                              if (state.isJulCrShow) ...[
                                const DataColumn(
                                  label: Text("กค (CR)"),
                                ),
                              ],
                              if (state.isAugDrShow) ...[
                                const DataColumn(
                                  label: Text("สค (DR)"),
                                ),
                              ],
                              if (state.isAugCrShow) ...[
                                const DataColumn(
                                  label: Text("สค (CR)"),
                                ),
                              ],
                              if (state.isSepDrShow) ...[
                                const DataColumn(
                                  label: Text("กย (DR)"),
                                ),
                              ],
                              if (state.isSepCrShow) ...[
                                const DataColumn(
                                  label: Text("กย (CR)"),
                                ),
                              ],
                              if (state.isOctDrShow) ...[
                                const DataColumn(
                                  label: Text("ตค (DR)"),
                                ),
                              ],
                              if (state.isOctCrShow) ...[
                                const DataColumn(
                                  label: Text("ตค (CR)"),
                                ),
                              ],
                              if (state.isNovDrShow) ...[
                                const DataColumn(
                                  label: Text("พศ (DR)"),
                                ),
                              ],
                              if (state.isNovCrShow) ...[
                                const DataColumn(
                                  label: Text("พศ (CR)"),
                                ),
                              ],
                              if (state.isDecDrShow) ...[
                                const DataColumn(
                                  label: Text("ธค (DR)"),
                                ),
                              ],
                              if (state.isDecCrShow) ...[
                                const DataColumn(
                                  label: Text("ธค (CR)"),
                                ),
                              ],
                              if (state.isTotalDrShow) ...[
                                const DataColumn(
                                  label: Text("Total (DR)"),
                                ),
                              ],
                              if (state.isTotalCrShow) ...[
                                const DataColumn(
                                  label: Text("Total (CR)"),
                                ),
                              ],
                              if (state.isBalanceShow) ...[
                                const DataColumn(
                                  label: Text("Ending"),
                                ),
                              ],
                            ],
                            source: ChildAccountBalanceDataSource(
                              state: state,
                              data: data.child,
                              context: context,
                              onDetailButtonPressed: (data) {},
                            ),
                          ),
                        ),
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

class ChildAccountBalanceDataSource extends DataTableSource {
  final ReportFinancialStatementListState state;
  final List<ChildAccountBalance> data;
  final BuildContext context;
  final void Function(AccountDetail data) onDetailButtonPressed;
  final oCcy = NumberFormat("#,##0.00", "en_US");

  ChildAccountBalanceDataSource({
    required this.state,
    required this.data,
    required this.context,
    required this.onDetailButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    ChildAccountBalance row = data[index];
    return DataRow(
      cells: [
        DataCell(Text(row.accountCode)),
        DataCell(Text(row.accountName)),
        if (state.isForwardDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.forwardDr)))),
        ],
        if (state.isForwardCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.forwardCr)))),
        ],
        if (state.isJanDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.janDr)))),
        ],
        if (state.isJanCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.janCr)))),
        ],
        if (state.isFebDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.febDr)))),
        ],
        if (state.isFebCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.febCr)))),
        ],
        if (state.isMarDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.marDr)))),
        ],
        if (state.isMarCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.marCr)))),
        ],
        if (state.isAprDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.aprDr)))),
        ],
        if (state.isAprCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.aprCr)))),
        ],
        if (state.isMayDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.mayDr)))),
        ],
        if (state.isMayCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.mayCr)))),
        ],
        if (state.isJunDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.junDr)))),
        ],
        if (state.isJunCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.junCr)))),
        ],
        if (state.isJulDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.julDr)))),
        ],
        if (state.isJulCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.julCr)))),
        ],
        if (state.isAugDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.augDr)))),
        ],
        if (state.isAugCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.augCr)))),
        ],
        if (state.isSepDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sepDr)))),
        ],
        if (state.isSepCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.sepCr)))),
        ],
        if (state.isOctDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.octDr)))),
        ],
        if (state.isOctCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.octCr)))),
        ],
        if (state.isNovDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.novDr)))),
        ],
        if (state.isNovCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.novCr)))),
        ],
        if (state.isDecDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.decDr)))),
        ],
        if (state.isDecCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.decCr)))),
        ],
        if (state.isTotalDrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.totalDr)))),
        ],
        if (state.isTotalCrShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.totalCr)))),
        ],
        if (state.isBalanceShow) ...[
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text(oCcy.format(row.balance)))),
        ],
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
