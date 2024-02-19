import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/customer/form/customer_form.dart';
import 'package:saved/customer/form/view/customer_form.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

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

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return CustomerFormBloc()
            ..add(CustomerFormStarted(provider, widget.id));
        },
        child: ListView(
            padding: const EdgeInsets.all(kDefaultPadding),
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: CustomerForm()),
            ]),
      ),
    );
  }
}
