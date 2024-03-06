import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/dashboard/dashboard.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';
import 'package:findigitalservice/widgets/portal_master_layout/portal_master_layout.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return DashboardBloc(provider)..add(const DashboardStarted());
        },
        child: ListView(
          padding: const EdgeInsets.all(kDefaultPadding),
          children: [
            Text(
              "${lang.dashboard} - ${provider.companyName}",
              style: themeData.textTheme.headlineMedium,
            ),
            const Padding(
                // padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                padding: EdgeInsets.only(top: kDefaultPadding * 1.5),
                child: DashboardCardList()),
          ],
        ),
      ),
    );
  }
}

class DashboardCardList extends StatelessWidget {
  const DashboardCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final appColorScheme = themeData.extension<AppColorScheme>()!;
    final size = MediaQuery.of(context).size;
    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);
    final provider = context.read<AppProvider>();

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return switch (state) {
          DashboardLoading() =>
            const Center(child: CircularProgressIndicator()),
          DashboardError() => const Text('Something went wrong!'),
          DashboardLoaded() => LayoutBuilder(
              builder: (context, constraints) {
                final summaryCardWidth = ((constraints.maxWidth -
                        (kDefaultPadding * (summaryCardCrossAxisCount - 1))) /
                    summaryCardCrossAxisCount);
                DateTime now = DateTime.now();

                return Wrap(
                  direction: Axis.horizontal,
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    SummaryCard(
                      title: lang.dDaybook(now.year.toString()),
                      value: state.daybookCount.toString(),
                      icon: Icons.library_books_rounded,
                      backgroundColor: appColorScheme.info,
                      textColor: themeData.colorScheme.onPrimary,
                      iconColor: Colors.black12,
                      width: summaryCardWidth,
                      route: RouteUri.daybook,
                    ),
                    if (provider.role == 'admin') ...[
                      SummaryCard(
                        title: lang.user(num.parse(state.userCount.toString())),
                        value: state.userCount.toString(),
                        icon: Icons.person_rounded,
                        backgroundColor: appColorScheme.warning,
                        textColor: appColorScheme.buttonTextBlack,
                        iconColor: Colors.black12,
                        width: summaryCardWidth,
                        route: RouteUri.user,
                      ),
                    ],
                  ],
                );
              },
            ),
        };
      },
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double width;
  final String route;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.width,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 120.0,
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: InkWell(
          onTap: () => GoRouter.of(context).go(route),
          child: Stack(
            children: [
              Positioned(
                top: kDefaultPadding * 0.5,
                right: kDefaultPadding * 0.5,
                child: Icon(
                  icon,
                  size: 80.0,
                  color: iconColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: kDefaultPadding * 0.5),
                      child: Text(
                        value,
                        style: textTheme.headlineMedium!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: textTheme.labelLarge!.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
