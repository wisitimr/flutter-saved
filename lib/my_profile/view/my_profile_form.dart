import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/app_router.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/generated/l10n.dart';
import 'package:saved/my_profile/bloc/my_profile_bloc.dart';
import 'package:saved/theme/theme_extensions/app_button_theme.dart';
import 'package:saved/theme/theme_extensions/app_color_scheme.dart';
import 'package:saved/theme/theme_extensions/app_data_table_theme.dart';
import 'package:saved/widgets/card_elements.dart';

class MyProfileForm extends StatelessWidget {
  const MyProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

    return BlocListener<MyProfileBloc, MyProfileState>(
      listener: (context, state) {
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
        } else if (state.status.isSubmitConfirmation) {
          final dialog = AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            desc: lang.confirmSubmitRecord,
            width: kDialogWidth,
            btnOkText: lang.ok,
            btnOkColor: appColorScheme.primary,
            btnOkOnPress: () {
              context.read<MyProfileBloc>().add(const MyProfileSubmitted());
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
            btnOkOnPress: () {},
          );

          dialog.show();
        }
      },
      child: BlocBuilder<MyProfileBloc, MyProfileState>(
        builder: (context, state) {
          switch (state.status) {
            case MyProfileStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case MyProfileStatus.failure:
              return const MyProfileDetail();
            case MyProfileStatus.submited:
              return const MyProfileDetail();
            case MyProfileStatus.submitConfirmation:
              return const MyProfileDetail();
            case MyProfileStatus.success:
              return const MyProfileDetail();
          }
        },
      ),
    );
  }
}

class MyProfileDetail extends StatelessWidget {
  const MyProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final formKey = GlobalKey<FormBuilderState>();
    final dataTableHorizontalScrollController = ScrollController();

    return BlocBuilder<MyProfileBloc, MyProfileState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: lang.myProfile,
              ),
              CardBody(
                child: FormBuilder(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 1.5),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(state.imageUrl),
                              radius: 60.0,
                            ),
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: SizedBox(
                                height: 40.0,
                                width: 40.0,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: themeData
                                      .extension<AppButtonTheme>()!
                                      .secondaryElevated
                                      .copyWith(
                                        shape: MaterialStateProperty.all(
                                            const CircleBorder()),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                      ),
                                  child: const Icon(
                                    Icons.edit_rounded,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 1.5),
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
                          onSaved: (username) => context
                              .read<MyProfileBloc>()
                              .add(MyProfileUsernameChanged(username!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 1.5),
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
                          onSaved: (firstName) => context
                              .read<MyProfileBloc>()
                              .add(MyProfileFirstNameChanged(firstName!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 1.5),
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
                          onSaved: (lastName) => context
                              .read<MyProfileBloc>()
                              .add(MyProfileLastNameChanged(lastName!)),
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
                          keyboardType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.required(),
                          onSaved: (email) => context
                              .read<MyProfileBloc>()
                              .add(MyProfileEmailChanged(email!)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(lang.companies),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: kDefaultPadding),
                            child: SizedBox(
                              height: 40.0,
                              child: ElevatedButton(
                                style: themeData
                                    .extension<AppButtonTheme>()!
                                    .successElevated,
                                onPressed: () =>
                                    GoRouter.of(context).go(RouteUri.company),
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
                                controller: dataTableHorizontalScrollController,
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
                                        cardTheme: appDataTableTheme.cardTheme,
                                        dataTableTheme: appDataTableTheme
                                            .dataTableThemeData,
                                      ),
                                      child: DataTable(
                                        showCheckboxColumn: false,
                                        showBottomBorder: true,
                                        columns: [
                                          DataColumn(label: Text(lang.select)),
                                          DataColumn(label: Text(lang.name)),
                                        ],
                                        rows: List.generate(
                                            state.companies.length, (index) {
                                          var row = state.companies[index];
                                          return DataRow(
                                              cells: [
                                                DataCell(
                                                  ListTile(
                                                    leading: Radio(
                                                      value: row.id,
                                                      groupValue:
                                                          state.companySelected,
                                                      onChanged: (enable) {
                                                        context
                                                            .read<
                                                                MyProfileBloc>()
                                                            .add(
                                                              MyProfileCompanySelected(
                                                                context.read<
                                                                    AppProvider>(),
                                                                row.id,
                                                                row.name,
                                                              ),
                                                            );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                DataCell(Text(row.name)),
                                              ],
                                              onSelectChanged: (value) async {
                                                final query = '?id=${row.id}';
                                                GoRouter.of(context).go(
                                                    '${RouteUri.company}$query');
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
                                        .read<MyProfileBloc>()
                                        .add(const MyProfileConfirm());
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
                                    size: (themeData
                                            .textTheme.labelLarge!.fontSize! +
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
