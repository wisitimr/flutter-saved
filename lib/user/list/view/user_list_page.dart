import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saved/app_router.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/generated/l10n.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/theme/theme_extensions/app_button_theme.dart';
import 'package:saved/theme/theme_extensions/app_data_table_theme.dart';
import 'package:saved/user/list/user_list.dart';
import 'package:saved/widgets/card_elements.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UserPage());
  }
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return UserBloc()..add(UserStarted(provider));
        },
        child: ListView(
          padding: const EdgeInsets.all(kDefaultPadding),
          children: const [
            Padding(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: User()),
          ],
        ),
      ),
    );
  }
}

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final outputFormat = DateFormat('dd/MM/yyyy');
    final dataTableHorizontalScrollController = ScrollController();

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: lang.user(2),
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
                                  GoRouter.of(context).go(RouteUri.userForm),
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
                                                label: Text(lang.username)),
                                            DataColumn(
                                                label: Text(lang.firstName)),
                                            DataColumn(
                                                label: Text(lang.lastName)),
                                            DataColumn(
                                                label: Text(lang.createdAt)),
                                            DataColumn(
                                                label: Text(lang.updatedAt)),
                                          ],
                                          rows: List.generate(
                                              state.users.length, (index) {
                                            UserModel row = state.users[index];
                                            var createdAt = inputFormat
                                                .parse(row.createdAt);
                                            var updatedAt = inputFormat
                                                .parse(row.updatedAt);
                                            return DataRow(
                                                cells: [
                                                  DataCell(Text(row.username)),
                                                  DataCell(Text(row.firstName)),
                                                  DataCell(Text(row.lastName)),
                                                  DataCell(Text(outputFormat
                                                      .format(createdAt))),
                                                  DataCell(Text(outputFormat
                                                      .format(updatedAt))),
                                                ],
                                                onSelectChanged: (value) {
                                                  final query = '?id=${row.id}';
                                                  GoRouter.of(context).go(
                                                      '${RouteUri.userForm}$query');
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
