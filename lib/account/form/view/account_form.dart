import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:findigitalservice/account/form/account_form.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/theme/theme_extensions/app_button_theme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';
import 'package:findigitalservice/widgets/card_elements.dart';

class AccountForm extends StatelessWidget {
  final String id;

  const AccountForm({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);

    return BlocListener<AccountFormBloc, AccountFormState>(
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
              context.read<AccountFormBloc>().add(const AccountSubmitted());
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
      child: BlocBuilder<AccountFormBloc, AccountFormState>(
        builder: (context, state) {
          switch (state.status) {
            case AccountFormStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case AccountFormStatus.failure:
              return const AccountFormDetail();
            case AccountFormStatus.submited:
              return const AccountFormDetail();
            case AccountFormStatus.submitConfirmation:
              return const AccountFormDetail();
            case AccountFormStatus.success:
              return const AccountFormDetail();
          }
        },
      ),
    );
  }
}

class AccountFormDetail extends StatelessWidget {
  const AccountFormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final formKey = GlobalKey<FormBuilderState>();

    return BlocBuilder<AccountFormBloc, AccountFormState>(
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: lang.account,
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
                          name: 'code',
                          decoration: InputDecoration(
                            labelText: lang.code,
                            hintText: lang.code,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.code.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (code) => context
                              .read<AccountFormBloc>()
                              .add(AccountFormCodeChanged(code!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
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
                              .read<AccountFormBloc>()
                              .add(AccountFormNameChanged(name!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'description',
                          decoration: InputDecoration(
                            labelText: lang.description,
                            hintText: lang.description,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.description.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (description) => context
                              .read<AccountFormBloc>()
                              .add(AccountFormDescriptionChanged(description!)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: FormBuilderTextField(
                          name: 'type',
                          decoration: InputDecoration(
                            labelText: lang.type,
                            hintText: lang.type,
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.type.value,
                          validator: FormBuilderValidators.required(),
                          onChanged: (type) => context
                              .read<AccountFormBloc>()
                              .add(AccountFormTypeChanged(type!)),
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
                                  GoRouter.of(context).go(RouteUri.account),
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
                                        context.read<AccountFormBloc>().add(
                                            const AccountFormSubmitConfirm());
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
