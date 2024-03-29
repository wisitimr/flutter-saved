import 'package:flutter/material.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:findigitalservice/widgets/portal_master_layout/sidebar.dart';

final sidebarMenuConfigs = [
  SidebarMenuConfig(
    uri: RouteUri.dashboard,
    icon: Icons.dashboard_rounded,
    title: (context) => Lang.of(context).dashboard,
  ),
  SidebarMenuConfig(
    uri: RouteUri.daybook,
    icon: Icons.library_books_rounded,
    title: (context) => Lang.of(context).daybook,
  ),
  SidebarMenuConfig(
    uri: '',
    icon: Icons.bar_chart_rounded,
    title: (context) => Lang.of(context).report,
    children: [
      SidebarChildMenuConfig(
        uri: RouteUri.report + RouteUri.ledgerAccount,
        icon: Icons.splitscreen_rounded,
        title: (context) => Lang.of(context).ledgerAccount,
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.report + RouteUri.tb12,
        icon: Icons.splitscreen_rounded,
        title: (context) => Lang.of(context).tb12,
      ),
    ],
  ),
  SidebarMenuConfig(
    uri: '',
    icon: Icons.storage_rounded,
    title: (context) => Lang.of(context).database,
    children: [
      SidebarChildMenuConfig(
        uri: RouteUri.account,
        icon: Icons.account_balance_rounded,
        title: (context) => Lang.of(context).account,
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.supplier,
        icon: Icons.group_rounded,
        title: (context) => Lang.of(context).supplier,
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.customer,
        icon: Icons.group_rounded,
        title: (context) => Lang.of(context).customer,
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.product,
        icon: Icons.production_quantity_limits_rounded,
        title: (context) => Lang.of(context).product,
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.material,
        icon: Icons.settings_rounded,
        title: (context) => Lang.of(context).material,
      ),
    ],
  ),
];

final adminSidebarMenuConfigs = [
  SidebarMenuConfig(
    uri: RouteUri.user,
    icon: Icons.person_rounded,
    title: (context) => Lang.of(context).user(1),
  ),
];

const localeMenuConfigs = [
  LocaleMenuConfig(
    languageCode: 'en',
    name: 'English',
  ),
  LocaleMenuConfig(
    languageCode: 'th',
    name: 'Thai',
  ),
];
