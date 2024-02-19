import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/supplier/form/supplier_form.dart';
import 'package:saved/supplier/form/view/supplier_form.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

class SupplierFormPage extends StatefulWidget {
  final String id;

  const SupplierFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<SupplierFormPage> createState() => _SupplierFormPageState();
}

class _SupplierFormPageState extends State<SupplierFormPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return SupplierFormBloc()
            ..add(SupplierFormStarted(provider, widget.id));
        },
        child: ListView(
            padding: const EdgeInsets.all(kDefaultPadding),
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: SupplierForm()),
            ]),
      ),
    );
  }
}
