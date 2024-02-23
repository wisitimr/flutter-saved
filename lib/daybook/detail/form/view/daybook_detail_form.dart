import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/daybook/detail/form/bloc/daybook_detail_form_bloc.dart';
import 'package:findigitalservice/models/master/ms_account.dart';
import 'package:findigitalservice/theme/theme_extensions/app_button_theme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';
import 'package:findigitalservice/widgets/card_elements.dart';

class DaybookDetailForm extends StatelessWidget {
  final String id;
  final String daybook;

  const DaybookDetailForm({
    Key? key,
    required this.id,
    required this.daybook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);
    return BlocListener<DaybookDetailFormBloc, DaybookDetailFormState>(
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
        } else if (state.status.isSubmitConfirmation) {
          final dialog = AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            desc: lang.confirmSubmitRecord,
            width: kDialogWidth,
            btnOkText: lang.ok,
            btnOkColor: appColorScheme.primary,
            btnOkOnPress: () {
              context
                  .read<DaybookDetailFormBloc>()
                  .add(const DaybookDetailSubmitted());
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
      child: BlocBuilder<DaybookDetailFormBloc, DaybookDetailFormState>(
        builder: (context, state) {
          switch (state.status) {
            case DaybookDetailFormStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DaybookDetailFormStatus.failure:
              return const DaybookDetailFormDetail();
            case DaybookDetailFormStatus.submited:
              return const DaybookDetailFormDetail();
            case DaybookDetailFormStatus.submitConfirmation:
              return const DaybookDetailFormDetail();
            case DaybookDetailFormStatus.success:
              return const DaybookDetailFormDetail();
          }
        },
      ),
    );
  }
}

class DaybookDetailFormDetail extends StatelessWidget {
  const DaybookDetailFormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final formKey = GlobalKey<FormBuilderState>();
    final provider = context.read<AppProvider>();

    return BlocBuilder<DaybookDetailFormBloc, DaybookDetailFormState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: lang.daybookDetail,
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
                            bottom: kDefaultPadding * 2.0,
                            top: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'name',
                          decoration: InputDecoration(
                            labelText: lang.name,
                            hintText: lang.name,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.name.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (name) => context
                              .read<DaybookDetailFormBloc>()
                              .add(DaybookDetailFormNameChanged(name!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderDropdown(
                          name: 'type',
                          decoration: InputDecoration(
                            labelText: lang.type,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                          ),
                          validator: FormBuilderValidators.required(),
                          items: state.msAccountType
                              .map((String e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(lang.getAccoutingType(e)),
                                  ))
                              .toList(),
                          initialValue: state.type.value,
                          onChanged: (type) => context
                              .read<DaybookDetailFormBloc>()
                              .add(DaybookDetailFormTypeChanged(type!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderDropdown(
                          name: 'account',
                          decoration: InputDecoration(
                            labelText: lang.account,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                          ),
                          validator: FormBuilderValidators.required(),
                          items: state.msAccount
                              .map((MsAccount e) => DropdownMenuItem(
                                    value: e.id,
                                    child: e.id != ""
                                        ? Text("${e.code} - ${e.name}")
                                        : Text(e.name),
                                  ))
                              .toList(),
                          initialValue: state.account.value,
                          onChanged: (account) => context
                              .read<DaybookDetailFormBloc>()
                              .add(DaybookDetailFormAccountChanged(account!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'amount',
                          decoration: InputDecoration(
                            labelText: lang.amount,
                            hintText: lang.amount,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(?!,$)[\d,.]+$'))
                          ],
                          initialValue: state.amount.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (amount) => context
                              .read<DaybookDetailFormBloc>()
                              .add(DaybookDetailFormAmountChanged(amount!)),
                        ),
                      ),
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
                                  GoRouter.of(context).go(provider.previous),
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
                                        context.read<DaybookDetailFormBloc>().add(
                                            const DaybookDetailFormSubmitConfirm());
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
