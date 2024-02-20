import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:saved/customer/form/customer_form.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/app_router.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/generated/l10n.dart';
import 'package:saved/theme/theme_extensions/app_button_theme.dart';
import 'package:saved/widgets/bottom_loader.dart';
import 'package:saved/widgets/card_elements.dart';

class CustomerForm extends StatelessWidget {
  const CustomerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerFormBloc, CustomerFormState>(
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
                GoRouter.of(context).go(RouteUri.customer);
              },
            );

            dialog.show();
          }
        },
        child: const CustomerFormDetail());
  }
}

class CustomerFormDetail extends StatelessWidget {
  const CustomerFormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final formKey = GlobalKey<FormBuilderState>();

    return BlocBuilder<CustomerFormBloc, CustomerFormState>(
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
                    title: lang.customer,
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.code.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (code) => context
                                  .read<CustomerFormBloc>()
                                  .add(CustomerFormCodeChanged(code!)),
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.name.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (name) => context
                                  .read<CustomerFormBloc>()
                                  .add(CustomerFormNameChanged(name!)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderTextField(
                              name: 'address',
                              decoration: InputDecoration(
                                labelText: lang.address,
                                hintText: lang.address,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.address.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (address) => context
                                  .read<CustomerFormBloc>()
                                  .add(CustomerFormAddressChanged(address!)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderTextField(
                              name: 'tax',
                              decoration: InputDecoration(
                                labelText: lang.tax,
                                hintText: lang.tax,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.tax.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (tax) => context
                                  .read<CustomerFormBloc>()
                                  .add(CustomerFormTaxChanged(tax!)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderTextField(
                              name: 'phone',
                              decoration: InputDecoration(
                                labelText: lang.phone,
                                hintText: lang.phone,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.phone.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (phone) => context
                                  .read<CustomerFormBloc>()
                                  .add(CustomerFormPhoneChanged(phone!)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderTextField(
                              name: 'contact',
                              decoration: InputDecoration(
                                labelText: lang.contact,
                                hintText: lang.contact,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.contact.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (contact) => context
                                  .read<CustomerFormBloc>()
                                  .add(CustomerFormContactChanged(contact!)),
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
                                  onPressed: () async => GoRouter.of(context)
                                      .go(RouteUri.customer),
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
                                                      .read<CustomerFormBloc>()
                                                      .add(CustomerSubmitted(
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
