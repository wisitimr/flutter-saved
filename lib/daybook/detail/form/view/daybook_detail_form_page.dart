import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/daybook/detail/form/bloc/daybook_detail_form_bloc.dart';
import 'package:findigitalservice/daybook/detail/form/view/daybook_detail_form.dart';
import 'package:findigitalservice/widgets/portal_master_layout/portal_master_layout.dart';

class DaybookDetailFormPage extends StatefulWidget {
  final String id;
  final String daybook;
  final bool isHistory;

  const DaybookDetailFormPage({
    Key? key,
    required this.id,
    required this.daybook,
    required this.isHistory,
  }) : super(key: key);

  @override
  State<DaybookDetailFormPage> createState() => _DaybookDetailFormPageState();
}

class _DaybookDetailFormPageState extends State<DaybookDetailFormPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return DaybookDetailFormBloc(provider)
            ..add(DaybookDetailFormStarted(
                widget.id, widget.daybook, widget.isHistory));
        },
        child:
            ListView(padding: const EdgeInsets.all(kDefaultPadding), children: [
          Text(
            provider.companyName,
            style: themeData.textTheme.headlineMedium,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: DaybookDetailForm(
                id: widget.id,
                daybook: widget.daybook,
                isHistory: widget.isHistory,
              )),
        ]),
      ),
    );
  }
}
