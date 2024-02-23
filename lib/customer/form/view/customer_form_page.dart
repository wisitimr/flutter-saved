import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/customer/form/customer_form.dart';
import 'package:findigitalservice/customer/form/view/customer_form.dart';
import 'package:findigitalservice/widgets/portal_master_layout/portal_master_layout.dart';

class CustomerFormPage extends StatefulWidget {
  final String id;

  const CustomerFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return CustomerFormBloc(provider)
            ..add(CustomerFormStarted(widget.id));
        },
        child:
            ListView(padding: const EdgeInsets.all(kDefaultPadding), children: [
          Text(
            provider.companyName,
            style: themeData.textTheme.headlineMedium,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: CustomerForm()),
        ]),
      ),
    );
  }
}
