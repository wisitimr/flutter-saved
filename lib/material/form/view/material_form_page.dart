import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/material/form/material_form.dart';
import 'package:saved/material/form/view/material_form.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

class MaterialFormPage extends StatefulWidget {
  final String id;

  const MaterialFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MaterialFormPage> createState() => _MaterialFormPageState();
}

class _MaterialFormPageState extends State<MaterialFormPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return MaterialFormBloc(provider)
            ..add(MaterialFormStarted(widget.id));
        },
        child:
            ListView(padding: const EdgeInsets.all(kDefaultPadding), children: [
          Text(
            provider.companyName,
            style: themeData.textTheme.headlineMedium,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: MaterialForm()),
        ]),
      ),
    );
  }
}
