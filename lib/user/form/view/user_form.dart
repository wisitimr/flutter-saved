import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/app_router.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/generated/l10n.dart';
import 'package:saved/theme/theme_extensions/app_button_theme.dart';
import 'package:saved/theme/theme_extensions/app_data_table_theme.dart';
import 'package:saved/user/form/user_form.dart';
import 'package:saved/widgets/bottom_loader.dart';
import 'package:saved/widgets/card_elements.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserFormBloc, UserFormState>(
        listener: (context, state) {
          // print(state.status);
          if (state.status.isFailure) {
            final dialog = AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              desc: state.message,
              width: kDialogWidth,
              btnOkText: 'OK',
              btnOkOnPress: () {},
            );

            dialog.show();
          } else if (state.status.isSuccess) {
            final dialog = AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              desc: state.message,
              width: kDialogWidth,
              btnOkText: 'OK',
              btnOkOnPress: () async {
                GoRouter.of(context).go(RouteUri.daybook);
              },
            );

            dialog.show();
          }
        },
        child: const UserFormDetail());
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
        switch (state.isLoading) {
          case true:
            return const Center(child: CircularProgressIndicator());
          case false:
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                              ),
                              validator: FormBuilderValidators.required(),
                              items: state.roles
                                  .map((r) => DropdownMenuItem(
                                        value: r,
                                        child: Text(r),
                                      ))
                                  .toList(),
                              initialValue: state.role.isValid
                                  ? state.role.value
                                  : 'user',
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
                                              size: (themeData.textTheme
                                                      .labelLarge!.fontSize! +
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
                                              dataTableTheme: appDataTableTheme
                                                  .dataTableThemeData,
                                            ),
                                            child: DataTable(
                                              showCheckboxColumn: false,
                                              showBottomBorder: true,
                                              columns: [
                                                DataColumn(
                                                    label: Text(lang.name)),
                                                DataColumn(
                                                    label:
                                                        Text(lang.description)),
                                              ],
                                              rows: List.generate(
                                                  state.companies.length,
                                                  (index) {
                                                var row =
                                                    state.companies[index];
                                                return DataRow(
                                                    cells: [
                                                      DataCell(Text(row.name)),
                                                      DataCell(Text(
                                                          row.description)),
                                                    ],
                                                    onSelectChanged:
                                                        (value) async {
                                                      final query =
                                                          '?id=${row.id}';
                                                      GoRouter.of(context).go(
                                                          '${RouteUri.userCompanyForn}$query');
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: kDefaultPadding * 0.5),
                                        child: Icon(
                                          Icons.arrow_circle_left_outlined,
                                          size: (themeData.textTheme.labelLarge!
                                                  .fontSize! +
                                              4.0),
                                        ),
                                      ),
                                      Text(lang.crudBack),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              state.isLoading
                                  ? const BottomLoader()
                                  : Align(
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
                                                      .add(UserSubmitted(
                                                          context.read<
                                                              AppProvider>()));
                                                }
                                              : null),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right:
                                                        kDefaultPadding * 0.5),
                                                child: Icon(
                                                  Icons.save_rounded,
                                                  size: (themeData
                                                          .textTheme
                                                          .labelLarge!
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
        }
      },
    );
  }
}
