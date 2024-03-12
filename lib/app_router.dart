import 'package:findigitalservice/report/ledger_account/list/view/report_ledger_account_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:findigitalservice/account/form/view/account_form_page.dart';
import 'package:findigitalservice/account/list/view/view.dart';
import 'package:findigitalservice/company/company.dart';
import 'package:findigitalservice/customer/form/customer_form.dart';
import 'package:findigitalservice/customer/list/view/view.dart';
import 'package:findigitalservice/dashboard/dashboard.dart';
import 'package:findigitalservice/daybook/detail/form/view/daybook_detail_form_page.dart';
import 'package:findigitalservice/daybook/form/view/daybook_form_page.dart';
import 'package:findigitalservice/daybook/list/view/daybook_list_page.dart';
import 'package:findigitalservice/login/view/login_page.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/master_layout_config.dart';
import 'package:findigitalservice/material/form/view/view.dart';
import 'package:findigitalservice/material/list/view/material_list_page.dart';
import 'package:findigitalservice/my_profile/view/my_profile_page.dart';
import 'package:findigitalservice/product/form/view/view.dart';
import 'package:findigitalservice/product/list/view/product_list_page.dart';
import 'package:findigitalservice/register/register.dart';
import 'package:findigitalservice/supplier/form/view/view.dart';
import 'package:findigitalservice/supplier/list/view/view.dart';
import 'package:findigitalservice/user/company/user_company.dart';
import 'package:findigitalservice/user/form/user_form.dart';
import 'package:findigitalservice/user/list/user_list.dart';
import 'package:findigitalservice/widgets/error_layout.dart';
import 'package:findigitalservice/widgets/logout_layout.dart';
import 'package:findigitalservice/widgets/portal_master_layout/sidebar.dart';

class RouteUri {
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String daybook = '/daybook';
  static const String daybookForm = '/daybook-form';
  static const String daybookDetailForm = '/daybook-detail-from';
  static const String report = '/report';
  static const String ledgerAccount = '/ledger';
  static const String ledgerAccountForn = '/ledger-form';
  static const String financialStatement = '/financial/statement';
  static const String financialStatementForn = '/financial/statement-form';
  static const String user = '/user';
  static const String userForm = '/user-form';
  static const String userCompanyForn = '/user-company-form';
  static const String company = '/company';
  static const String myProfile = '/my-profile';
  static const String logout = '/logout';
  static const String error404 = '/404';
  static const String login = '/login';
  static const String register = '/register';
  static const String crud = '/crud';
  static const String crudDetail = '/crud-detail';
  static const String account = '/account';
  static const String accountForm = '/account-form';
  static const String supplier = '/supplier';
  static const String supplierForm = '/supplier-form';
  static const String customer = '/customer';
  static const String customerForm = '/customer-form';
  static const String material = '/material';
  static const String materialForm = '/material-form';
  static const String product = '/product';
  static const String productForm = '/product-form';
}

const List<String> unrestrictedRoutes = [
  RouteUri.error404,
  RouteUri.logout,
  RouteUri.login, // Remove this line for actual authentication flow.
  RouteUri.register, // Remove this line for actual authentication flow.
];

const List<String> publicRoutes = [
  // RouteUri.login, // Enable this line for actual authentication flow.
  // RouteUri.register, // Enable this line for actual authentication flow.
];

GoRouter appRouter(AppProvider provider) {
  return GoRouter(
    initialLocation: RouteUri.home,
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: const ErrorScreen(),
    ),
    routes: [
      GoRoute(
        path: RouteUri.home,
        redirect: (context, state) => RouteUri.dashboard,
      ),
      GoRoute(
        path: RouteUri.dashboard,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.daybook,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DaybookListPage(
            year: state.queryParameters['year'] ?? '0',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.daybookForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DaybookFormPage(
            id: state.queryParameters['id'] ?? '',
            isHistory:
                state.queryParameters['isHistory'] == 'true' ? true : false,
            isNew: state.queryParameters['isNew'] == 'true' ? true : false,
            year: state.queryParameters['year'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.daybookDetailForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DaybookDetailFormPage(
            id: state.queryParameters['id'] ?? '',
            daybook: state.queryParameters['daybook'] ?? '',
            isHistory:
                state.queryParameters['isHistory'] == 'true' ? true : false,
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.company,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CompanyPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.myProfile,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const MyProfilePage(),
        ),
      ),
      GoRoute(
        path: RouteUri.logout,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LogoutLayout(),
        ),
      ),
      GoRoute(
        path: RouteUri.login,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.register,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const RegisterPage(),
          );
        },
      ),
      GoRoute(
        path: RouteUri.user,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const UserPage(),
          );
        },
      ),
      GoRoute(
        path: RouteUri.userForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: UserFormPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.userCompanyForn,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: UserCompanyPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.account,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const AccountPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.accountForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: AccountFormPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.supplier,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const SupplierPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.supplierForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SupplierFormPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.customer,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const CustomerPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.customerForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CustomerFormPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.material,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const MaterialListPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.materialForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: MaterialFormPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.product,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const ProductPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.productForm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ProductFormPage(
            id: state.queryParameters['id'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RouteUri.report + RouteUri.financialStatement,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ReportLedgerAccountListPage(
            year: state.queryParameters['year'] ?? '0',
          ),
        ),
      ),
      // GoRoute(
      //   path: RouteUri.report + RouteUri.financialStatementForn,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const FinancialStatementPage(),
      //   ),
      // ),
    ],
    redirect: (context, state) async {
      final provider = context.read<AppProvider>();
      List<SidebarMenuConfig> sidebarMenu = [];
      if (provider.isAdmin) {
        sidebarMenu = sidebarMenuConfigs + adminSidebarMenuConfigs;
      } else {
        sidebarMenu = sidebarMenuConfigs;
      }
      if (sidebarMenu.any((el) {
        return el.uri == state.matchedLocation ||
            el.children.any((elc) => elc.uri == state.matchedLocation);
      })) {
        await Future.wait([
          provider.clearPrevious(),
          provider.setCurrent(state.matchedLocation),
        ]);
      } else {
        var query = "";
        state.queryParameters.forEach((key, value) {
          if (query == "") {
            query += '?';
          } else {
            query += '&';
          }
          query += '$key=$value';
        });
        String current = state.matchedLocation + query;
        String previous = provider.current;

        if (current != provider.current) {
          await provider.setCurrent(current);
          await provider.setPrevious(previous);
        }
      }
      if (unrestrictedRoutes.contains(state.matchedLocation)) {
        return null;
      } else if (publicRoutes.contains(state.matchedLocation)) {
        // Is public route.
        if (provider.isUserLoggedIn()) {
          // User is logged in, redirect to home page.
          return RouteUri.home;
        }
      } else {
        // Not public route.
        if (!provider.isUserLoggedIn()) {
          // User is not logged in, redirect to login page.
          return RouteUri.login;
        }
      }

      return null;
    },
  );
}
