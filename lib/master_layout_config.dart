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
    uri: '',
    icon: Icons.library_books_rounded,
    title: (context) => Lang.of(context).daybook,
    children: [
      SidebarChildMenuConfig(
        uri: RouteUri.daybook,
        icon: Icons.pending_actions,
        title: (context) => Lang.of(context).task,
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.daybookHistory,
        icon: Icons.history_rounded,
        title: (context) => Lang.of(context).history,
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
