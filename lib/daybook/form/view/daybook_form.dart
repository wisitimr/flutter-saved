import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:findigitalservice/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/daybook/form/daybook_form.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/models/master/ms_supplier.dart';
import 'package:findigitalservice/theme/theme_extensions/app_button_theme.dart';
import 'package:intl/intl.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_data_table_theme.dart';
import 'package:findigitalservice/widgets/card_elements.dart';

class DaybookForm extends StatelessWidget {
  final String id;

  const DaybookForm({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final lang = Lang.of(context);
    return BlocListener<DaybookFormBloc, DaybookFormState>(
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
        } else if (state.status.isDeleteConfirmation) {
          final dialog = AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            desc: lang.confirmDeleteRecord,
            width: kDialogWidth,
            btnOkText: lang.ok,
            btnOkColor: appColorScheme.error,
            btnOkOnPress: () {
              context.read<DaybookFormBloc>().add(const DaybookFormDelete());
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
              context.read<DaybookFormBloc>().add(DaybookFormStarted(
                    id,
                    state.isHistory,
                    state.isNew,
                    state.year,
                  ));
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
              context.read<DaybookFormBloc>().add(const DaybookSubmitted());
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
            btnOkOnPress: () {
              if (state.isNew) {
                GoRouter.of(context).go(
                    '${RouteUri.daybookForm}?id=${state.id.value}&isHistory=${state.isHistory}&year=${state.year}&isNew=false');
              } else {
                GoRouter.of(context)
                    .go("${RouteUri.daybook}?year=${state.year}");
              }
            },
          );

          dialog.show();
        }
      },
      child: BlocBuilder<DaybookFormBloc, DaybookFormState>(
        builder: (context, state) {
          switch (state.status) {
            case DaybookFormStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DaybookFormStatus.failure:
              return const DaybookFormDetail();
            case DaybookFormStatus.deleteConfirmation:
              return const DaybookFormDetail();
            case DaybookFormStatus.deleted:
              return const DaybookFormDetail();
            case DaybookFormStatus.submitConfirmation:
              return const DaybookFormDetail();
            case DaybookFormStatus.submited:
              return const DaybookFormDetail();
            case DaybookFormStatus.success:
              return const DaybookFormDetail();
          }
        },
      ),
    );
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
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardHeader(
                title: state.isHistory ? lang.daybookHistory : lang.daybook,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.number.value,
                          validator: FormBuilderValidators.required(),
                          enabled: state.isHistory ? false : true,
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          initialValue: state.invoice.value,
                          validator: FormBuilderValidators.required(),
                          enabled: state.isHistory ? false : true,
                          onChanged: (invoice) => context
                              .read<DaybookFormBloc>()
                              .add(DaybookFormInvoiceChanged(invoice!)),
                        ),
                      ),
                      if (!state.isHistory) ...[
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
                            onChanged: (document) => state.isHistory
                                ? null
                                : context
                                    .read<DaybookFormBloc>()
                                    .add(DaybookFormDocumentChanged(document!)),
                          ),
                        ),
                      ],
                      if (state.isHistory) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: kDefaultPadding * 2.0),
                          child: FormBuilderTextField(
                            name: 'document',
                            decoration: InputDecoration(
                              labelText: lang.document,
                              hintText: lang.document,
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            initialValue: state.documentName,
                            validator: FormBuilderValidators.required(),
                            enabled: false,
                            onChanged: (document) => context
                                .read<DaybookFormBloc>()
                                .add(DaybookFormDocumentChanged(document!)),
                          ),
                        ),
                      ],
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
                          enabled: state.isHistory ? false : true,
                          onChanged: (transactionDate) => context
                              .read<DaybookFormBloc>()
                              .add(DaybookFormTransactionDateChanged(
                                  transactionDate!.toString())),
                        ),
                      ),
                      if (!state.isHistory) ...[
                        if (state.documentType == 'PAY') ...[
                          Padding(
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
                                          ? Text("${e.code} - ${e.name}")
                                          : Text(e.name)))
                                  .toList(),
                              initialValue: state.supplier.value,
                              enabled: state.isHistory ? false : true,
                              onChanged: (supplier) => context
                                  .read<DaybookFormBloc>()
                                  .add(DaybookFormSupplierChanged(supplier!)),
                            ),
                          ),
                        ],
                        if (state.documentType == 'REC') ...[
                          Padding(
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
                                  .map((MsCustomer e) => DropdownMenuItem(
                                        value: e.id,
                                        child: e.id != ""
                                            ? Text("${e.code} - ${e.name}")
                                            : Text(e.name),
                                      ))
                                  .toList(),
                              initialValue: state.customer.value,
                              enabled: state.isHistory ? false : true,
                              onChanged: (customer) => context
                                  .read<DaybookFormBloc>()
                                  .add(DaybookFormCustomerChanged(customer!)),
                            ),
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: kDefaultPadding * 2.0),
                          child: FormBuilderDropdown(
                            name: 'paymentMethod',
                            decoration: InputDecoration(
                              labelText: lang.paymentMethod,
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              isDense: true,
                            ),
                            items: state.msPaymentMethod
                                .map((MsPaymentMethod e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name),
                                    ))
                                .toList(),
                            initialValue: state.paymentMethod.value,
                            enabled: state.isHistory ? false : true,
                            onChanged: (paymentMethod) => context
                                .read<DaybookFormBloc>()
                                .add(DaybookFormPaymentMethodChanged(
                                    paymentMethod!)),
                          ),
                        ),
                      ],
                      if (state.isHistory) ...[
                        if (state.documentType == 'PAY') ...[
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderTextField(
                              name: 'supplier',
                              decoration: InputDecoration(
                                labelText: lang.supplier,
                                hintText: lang.supplier,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.supplierName,
                              validator: FormBuilderValidators.required(),
                              enabled: false,
                              onChanged: (supplier) {},
                            ),
                          ),
                        ],
                        if (state.documentType == 'REC') ...[
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultPadding * 2.0),
                            child: FormBuilderTextField(
                              name: 'customer',
                              decoration: InputDecoration(
                                labelText: lang.customer,
                                hintText: lang.customer,
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              initialValue: state.customerName,
                              validator: FormBuilderValidators.required(),
                              enabled: false,
                              onChanged: (customer) {},
                            ),
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: kDefaultPadding * 2.0),
                          child: FormBuilderTextField(
                            name: 'paymentMethod',
                            decoration: InputDecoration(
                              labelText: lang.paymentMethod,
                              hintText: lang.paymentMethod,
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            initialValue: state.paymentMethodName,
                            validator: FormBuilderValidators.required(),
                            enabled: false,
                            onChanged: (paymentMethod) {},
                          ),
                        ),
                      ],
                      if (!state.isNew || state.id.isValid) ...[
                        if (!state.isHistory) ...[
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
                        ],
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
                                                label: Text(lang.account)),
                                            DataColumn(label: Text(lang.type)),
                                            DataColumn(
                                                label: Text(lang.amount)),
                                            const DataColumn(
                                                label: Text(
                                              '...',
                                              textAlign: TextAlign.center,
                                            )),
                                          ],
                                          source: _DataSource(
                                            isHistory: state.isHistory,
                                            data: state.daybookDetail,
                                            context: context,
                                            onDetailButtonPressed: (data) {
                                              final query =
                                                  '?id=${data.id}&daybook=${state.id.value}&isHistory=${state.isHistory}';
                                              GoRouter.of(context).go(
                                                  '${RouteUri.daybookDetailForm}$query');
                                            },
                                            onDeleteButtonPressed: (data) =>
                                                context
                                                    .read<DaybookFormBloc>()
                                                    .add(
                                                        DaybookFormDeleteConfirm(
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
                              onPressed: () async => GoRouter.of(context)
                                  .go("${RouteUri.daybook}?year=${state.year}"),
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
                          if (!state.isHistory) ...[
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
                                          context.read<DaybookFormBloc>().add(
                                              const DaybookFormSubmitConfirm());
                                        }
                                      : null),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
  final bool isHistory;
  final List<DaybookDetailListModel> data;
  final BuildContext context;
  final void Function(DaybookDetailListModel data) onDetailButtonPressed;
  final void Function(DaybookDetailListModel data) onDeleteButtonPressed;

  _DataSource({
    required this.isHistory,
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

    DaybookDetailListModel row = data[index];
    return DataRow(
      cells: [
        DataCell(Text(row.name)),
        DataCell(Text("${row.account.code} - ${row.account.name}")),
        DataCell(Text(row.type)),
        DataCell(Text(row.amount.toStringAsFixed(2))),
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
                if (!isHistory) ...[
                  OutlinedButton.icon(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () => onDeleteButtonPressed.call(row),
                    style: Theme.of(context)
                        .extension<AppButtonTheme>()!
                        .errorOutlined,
                    label: Text(Lang.of(context).crudDelete),
                  ),
                ]
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
