import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/product/form/product_form.dart';
import 'package:saved/product/form/view/product_form.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

class ProductFormPage extends StatefulWidget {
  final String id;

  const ProductFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return ProductFormBloc(provider)..add(ProductFormStarted(widget.id));
        },
        child:
            ListView(padding: const EdgeInsets.all(kDefaultPadding), children: [
          Text(
            provider.companyName,
            style: themeData.textTheme.headlineMedium,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: ProductForm()),
        ]),
      ),
    );
  }
}
