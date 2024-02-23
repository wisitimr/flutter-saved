import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/company/models/company_model.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/theme/theme_extensions/app_button_theme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_data_table_theme.dart';
import 'package:findigitalservice/user/form/user_form.dart';
import 'package:findigitalservice/widgets/card_elements.dart';

class UserForm extends StatelessWidget {
  final String id;

  const UserForm({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

    return BlocListener<UserFormBloc, UserFormState>(
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
              context.read<UserFormBloc>().add(const UserFormDelete());
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
              context.read<UserFormBloc>().add(UserFormStarted(id));
            },
          );

          dialog.show();
        } else if (state.status.isSubmitConfirmation) {
          final dialog = AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            desc: lang.confirmSubmitRecord,
            width: kDialogWidth,
            btnOkText: lang.ok,
            btnOkColor: appColorScheme.primary,
            btnOkOnPress: () {
              context.read<UserFormBloc>().add(const UserSubmitted());
            },
            btnCancelText: lang.cancel,
            btnCancelColor: appColorScheme.secondary,
            btnCancelOnPress: () {},
          );

          dialog.show();
        } else if (state.status.isSubmited) {
          final dialog = AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            desc: state.message,
            width: kDialogWidth,
            btnOkText: lang.ok,
            btnOkOnPress: () => GoRouter.of(context).go(provider.previous),
          );

          dialog.show();
        }
      },
      child: BlocBuilder<UserFormBloc, UserFormState>(
        builder: (context, state) {
          switch (state.status) {
            case UserFormStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case UserFormStatus.failure:
              return const UserFormDetail();
            case UserFormStatus.deleteConfirmation:
              return const UserFormDetail();
            case UserFormStatus.deleted:
              return const UserFormDetail();
            case UserFormStatus.submitConfirmation:
              return const UserFormDetail();
            case UserFormStatus.submited:
              return const UserFormDetail();
            case UserFormStatus.success:
              return const UserFormDetail();
          }
        },
      ),
    );
  }
}

class UserFormDetail extends StatelessWidget {
  const UserFormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final formKey = GlobalKey<FormBuilderState>();
    final dataTableHorizontalScrollController = ScrollController();

    return BlocBuilder<UserFormBloc, UserFormState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: lang.user(1),
              ),
              CardBody(
                child: FormBuilder(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: kDefaultPadding * 2.0,
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'username',
                          decoration: InputDecoration(
                            labelText: lang.username,
                            hintText: lang.username,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.username.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (username) => context
                              .read<UserFormBloc>()
                              .add(UserFormUsernameChanged(username!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'firstName',
                          decoration: InputDecoration(
                            labelText: lang.firstName,
                            hintText: lang.firstName,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.firstName.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (firstName) => context
                              .read<UserFormBloc>()
                              .add(UserFormFirstNameChanged(firstName!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'lastName',
                          decoration: InputDecoration(
                            labelText: lang.lastName,
                            hintText: lang.lastName,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.lastName.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (lastName) => context
                              .read<UserFormBloc>()
                              .add(UserFormLastNameChanged(lastName!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'email',
                          decoration: InputDecoration(
                            labelText: lang.email,
                            hintText: lang.email,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.email.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (email) => context
                              .read<UserFormBloc>()
                              .add(UserFormEmailChanged(email!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderDropdown(
                          name: 'role',
                          decoration: InputDecoration(
                            labelText: lang.role,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                          ),
                          validator: FormBuilderValidators.required(),
                          items: state.roles
                              .map((r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r),
                                  ))
                              .toList(),
                          initialValue:
                              state.role.isValid ? state.role.value : 'user',
                          onChanged: (role) => context
                              .read<UserFormBloc>()
                              .add(UserFormRoleChanged(role!)),
                        ),
                      ),
                      if (state.id.isValid) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(lang.detail),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: kDefaultPadding),
                              child: SizedBox(
                                height: 40.0,
                                child: ElevatedButton(
                                  style: themeData
                                      .extension<AppButtonTheme>()!
                                      .successElevated,
                                  onPressed: () => GoRouter.of(context)
                                      .go(RouteUri.userCompanyForn),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          rowsPerPage: 5,
                                          columns: [
                                            DataColumn(label: Text(lang.name)),
                                            DataColumn(
                                                label: Text(lang.description)),
                                            const DataColumn(
                                                label: Text(
                                              '...',
                                              textAlign: TextAlign.center,
                                            )),
                                          ],
                                          source: _DataSource(
                                            data: state.companies,
                                            context: context,
                                            onDetailButtonPressed: (data) {
                                              final query = '?id=${data.id}';
                                              GoRouter.of(context).go(
                                                  '${RouteUri.userCompanyForn}$query');
                                            },
                                            onDeleteButtonPressed: (data) =>
                                                context
                                                    .read<UserFormBloc>()
                                                    .add(UserFormDeleteConfirm(
                                                        data.id)),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40.0,
                            child: ElevatedButton(
                              style: themeData
                                  .extension<AppButtonTheme>()!
                                  .secondaryElevated,
                              onPressed: () async =>
                                  GoRouter.of(context).go(RouteUri.user),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: kDefaultPadding * 0.5),
                                    child: Icon(
                                      Icons.arrow_circle_left_outlined,
                                      size: (themeData
                                              .textTheme.labelLarge!.fontSize! +
                                          4.0),
                                    ),
                                  ),
                                  Text(lang.crudBack),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: 40.0,
                              child: ElevatedButton(
                                style: themeData
                                    .extension<AppButtonTheme>()!
                                    .primaryElevated,
                                onPressed: (state.isValid
                                    ? () {
                                        context
                                            .read<UserFormBloc>()
                                            .add(const UserFormSubmitConfirm());
                                      }
                                    : null),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: kDefaultPadding * 0.5),
                                      child: Icon(
                                        Icons.save_rounded,
                                        size: (themeData.textTheme.labelLarge!
                                                .fontSize! +
                                            4.0),
                                      ),
                                    ),
                                    Text(lang.save),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final List<CompanyModel> data;
  final BuildContext context;
  final void Function(CompanyModel data) onDetailButtonPressed;
  final void Function(CompanyModel data) onDeleteButtonPressed;

  _DataSource({
    required this.data,
    required this.context,
    required this.onDetailButtonPressed,
    required this.onDeleteButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    CompanyModel row = data[index];
    return DataRow(
      cells: [
        DataCell(Text(row.name)),
        DataCell(Text(row.description)),
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
