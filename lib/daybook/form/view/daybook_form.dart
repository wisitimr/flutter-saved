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
import 'package:saved/models/master/ms_customer.dart';
import 'package:saved/models/master/ms_document.dart';
import 'package:saved/models/master/ms_supplier.dart';
import 'package:saved/daybook/form/bloc/daybook_form_bloc.dart';
import 'package:saved/theme/theme_extensions/app_button_theme.dart';
import 'package:intl/intl.dart';
import 'package:saved/theme/theme_extensions/app_data_table_theme.dart';
import 'package:saved/widgets/bottom_loader.dart';
import 'package:saved/widgets/card_elements.dart';

class DaybookForm extends StatelessWidget {
  const DaybookForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DaybookFormBloc, DaybookFormState>(
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
        child: const DaybookFormDetail());
  }
}

class DaybookFormDetail extends StatelessWidget {
  const DaybookFormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appDataTableTheme = themeData.extension<AppDataTableTheme>()!;
    final formKey = GlobalKey<FormBuilderState>();
    final dataTableHorizontalScrollController = ScrollController();

    return BlocBuilder<DaybookFormBloc, DaybookFormState>(
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
                    title: lang.daybook,
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
                              name: 'number',
                              decoration: InputDecoration(
                                labelText: lang.number,
                                hintText: lang.number,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.number.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (number) => context
                                  .read<DaybookFormBloc>()
                                  .add(DaybookFormNumberChanged(number!)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderTextField(
                              name: 'invoice',
                              decoration: InputDecoration(
                                labelText: lang.invoice,
                                hintText: lang.invoice,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.invoice.value,
                              validator: FormBuilderValidators.required(),
                              onChanged: (invoice) => context
                                  .read<DaybookFormBloc>()
                                  .add(DaybookFormInvoiceChanged(invoice!)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderDropdown(
                              name: 'document',
                              decoration: InputDecoration(
                                labelText: lang.document,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                              ),
                              validator: FormBuilderValidators.required(),
                              items: state.msDocument
                                  .map((MsDocument e) => DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              initialValue: state.document.value,
                              onChanged: (document) => context
                                  .read<DaybookFormBloc>()
                                  .add(DaybookFormDocumentChanged(document!)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderDateTimePicker(
                              name: 'transactionDate',
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                labelText: lang.transactionDate,
                                border: const OutlineInputBorder(),
                              ),
                              initialValue:
                                  DateTime.parse(state.transactionDate.value),
                              format: DateFormat('dd/MM/yyyy'),
                              onChanged: (transactionDate) => context
                                  .read<DaybookFormBloc>()
                                  .add(DaybookFormTransactionDateChanged(
                                      transactionDate!.toString())),
                            ),
                          ),
                          if (state.documentType == 'PAY') ...[
                            state.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kDefaultPadding * 2.0),
                                    child: FormBuilderDropdown(
                                      name: 'supplier',
                                      decoration: InputDecoration(
                                        labelText: lang.supplier,
                                        border: const OutlineInputBorder(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        isDense: true,
                                      ),
                                      items: state.msSupplier
                                          .map((MsSupplier e) => DropdownMenuItem(
                                              value: e.id,
                                              child: e.id != ""
                                                  ? Text(
                                                      "${e.code} - ${e.name}")
                                                  : Text(e.name)))
                                          .toList(),
                                      initialValue: state.supplier.value,
                                      onChanged: (supplier) => context
                                          .read<DaybookFormBloc>()
                                          .add(DaybookFormSupplierChanged(
                                              supplier!)),
                                    ),
                                  ),
                          ],
                          if (state.documentType == 'REC') ...[
                            state.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kDefaultPadding * 2.0),
                                    child: FormBuilderDropdown(
                                      name: 'customer',
                                      decoration: InputDecoration(
                                        labelText: lang.customer,
                                        border: const OutlineInputBorder(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        isDense: true,
                                      ),
                                      items: state.msCustomer
                                          .map((MsCustomer e) =>
                                              DropdownMenuItem(
                                                value: e.id,
                                                child: e.id != ""
                                                    ? Text(
                                                        "${e.code} - ${e.name}")
                                                    : Text(e.name),
                                              ))
                                          .toList(),
                                      initialValue: state.customer.value,
                                      onChanged: (customer) => context
                                          .read<DaybookFormBloc>()
                                          .add(DaybookFormCustomerChanged(
                                              customer!)),
                                    ),
                                  ),
                          ],
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
                                      onPressed: () => GoRouter.of(context).go(
                                          '${RouteUri.daybookDetailForm}?daybook=${state.id.value}'),
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
                                                    label: Text(lang.account)),
                                                DataColumn(
                                                    label: Text(lang.type)),
                                                DataColumn(
                                                    label: Text(lang.amount)),
                                              ],
                                              rows: List.generate(
                                                  state.daybookDetail.length,
                                                  (index) {
                                                var row =
                                                    state.daybookDetail[index];
                                                return DataRow(
                                                    cells: [
                                                      DataCell(Text(row.name)),
                                                      DataCell(Text(
                                                          "${row.account.code} - ${row.account.name}")),
                                                      DataCell(Text(
                                                          lang.getAccoutingType(
                                                              row.type))),
                                                      DataCell(Text(row.amount
                                                          .toStringAsFixed(2))),
                                                    ],
                                                    onSelectChanged:
                                                        (value) async {
                                                      final query =
                                                          '?id=${row.id}&daybook=${state.id.value}';
                                                      GoRouter.of(context).go(
                                                          '${RouteUri.daybookDetailForm}$query');
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
                                      GoRouter.of(context).go(RouteUri.daybook),
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
                                                      .read<DaybookFormBloc>()
                                                      .add(DaybookSubmitted(
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
