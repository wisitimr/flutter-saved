import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:saved/theme/theme_extensions/app_color_scheme.dart';
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
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: BlocListener<DaybookListBloc, DaybookListState>(
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
                            .read<DaybookListBloc>()
                            .add(const DaybookListDelete());
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
                            .read<DaybookListBloc>()
                            .add(const DaybookListStarted());
                      },
                    );

                    dialog.show();
                  }
                },
                child: BlocBuilder<DaybookListBloc, DaybookListState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case DaybookListStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case DaybookListStatus.failure:
                        return const DaybookList();
                      case DaybookListStatus.deleted:
                        return const DaybookList();
                      case DaybookListStatus.deleteConfirmation:
                        return const DaybookList();
                      case DaybookListStatus.success:
                        return const DaybookList();
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

class DaybookList extends StatelessWidget {
  const DaybookList({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final dataTableHorizontalScrollController = ScrollController();
    final key = GlobalKey<PaginatedDataTableState>();

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
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: lang.search,
                                    hintText: lang.search,
                                    border: const OutlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    isDense: true,
                                    suffixIcon: const Icon(Icons.search),
                                  ),
                                  onChanged: (text) => {
                                    context
                                        .read<DaybookListBloc>()
                                        .add(DaybookListSearchChanged(text)),
                                    key.currentState?.pageTo(0)
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
                                                  label: Text(
                                                '...',
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                            source: _DataSource(
                                              data: state.filter,
                                              context: context,
                                              onDetailButtonPressed: (data) =>
                                                  GoRouter.of(context).go(
                                                      '${RouteUri.daybookForm}?id=${data.id}'),
                                              onDeleteButtonPressed: (data) =>
                                                  context
                                                      .read<DaybookListBloc>()
                                                      .add(
                                                          DaybookListDeleteConfirm(
                                                              data.id)),
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
  final List<DaybookListModel> data;
  final BuildContext context;
  final void Function(DaybookListModel data) onDetailButtonPressed;
  final void Function(DaybookListModel data) onDeleteButtonPressed;

  _DataSource({
    required this.data,
    required this.context,
    required this.onDetailButtonPressed,
    required this.onDeleteButtonPressed,
  });
  final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
  final outputFormat = DateFormat('dd/MM/yyyy');

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    DaybookListModel row = data[index];
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
                    icon: const Icon(Icons.edit_document),
                    onPressed: () => onDetailButtonPressed.call(row),
                    style: Theme.of(context)
                        .extension<AppButtonTheme>()!
                        .primaryOutlined,
                    label: Text(Lang.of(context).crudDetail),
                  ),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: () => onDeleteButtonPressed.call(row),
                  style: Theme.of(context)
                      .extension<AppButtonTheme>()!
                      .errorOutlined,
                  label: Text(Lang.of(context).crudDelete),
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
