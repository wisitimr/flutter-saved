import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saved/app_router.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/generated/l10n.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/daybook/list/daybook_list.dart';
import 'package:saved/theme/theme_extensions/app_button_theme.dart';
import 'package:saved/theme/theme_extensions/app_data_table_theme.dart';
import 'package:saved/widgets/card_elements.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

class DaybookListPage extends StatefulWidget {
  const DaybookListPage({Key? key}) : super(key: key);

  @override
  State<DaybookListPage> createState() => _DaybookListPageState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DaybookListPage());
  }
}

class _DaybookListPageState extends State<DaybookListPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return DaybookListBloc(provider)..add(const DaybookListStarted());
        },
        child: ListView(
          padding: const EdgeInsets.all(kDefaultPadding),
          children: [
            Text(
              provider.companyName,
              style: themeData.textTheme.headlineMedium,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: DaybookList()),
          ],
        ),
      ),
    );
  }
}

class DaybookList extends StatelessWidget {
  const DaybookList({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final outputFormat = DateFormat('dd/MM/yyyy');
    final dataTableHorizontalScrollController = ScrollController();

    return BlocBuilder<DaybookListBloc, DaybookListState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: lang.daybook,
              ),
              CardBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              onPressed: () =>
                                  GoRouter.of(context).go(RouteUri.daybookForm),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: kDefaultPadding * 0.5),
                                    child: Icon(
                                      Icons.add,
                                      size: (themeData
                                              .textTheme.labelLarge!.fontSize! +
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
                                        child: DataTable(
                                          showCheckboxColumn: false,
                                          showBottomBorder: true,
                                          columns: [
                                            DataColumn(
                                                label: Text(lang.number)),
                                            DataColumn(
                                                label: Text(lang.invoice)),
                                            DataColumn(label: Text(lang.type)),
                                            DataColumn(
                                                label:
                                                    Text(lang.transactionDate)),
                                          ],
                                          rows: List.generate(
                                              state.daybooks.length, (index) {
                                            DaybookListModel row =
                                                state.daybooks[index];
                                            var inputDate = inputFormat
                                                .parse(row.transactionDate);
                                            return DataRow(
                                                cells: [
                                                  DataCell(Text(row.number)),
                                                  DataCell(Text(row.invoice)),
                                                  DataCell(Text(row.document)),
                                                  DataCell(Text(outputFormat
                                                      .format(inputDate))),
                                                ],
                                                onSelectChanged: (value) {
                                                  final query = '?id=${row.id}';
                                                  GoRouter.of(context).go(
                                                      '${RouteUri.daybookForm}$query');
                                                });
                                          }).toList(),
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
