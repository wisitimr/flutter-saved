import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/app_provider.dart';

class LogoutLayout extends StatefulWidget {
  const LogoutLayout({Key? key}) : super(key: key);

  @override
  State<LogoutLayout> createState() => _LogoutLayoutState();
}

class _LogoutLayoutState extends State<LogoutLayout> {
  Future<void> _doLogoutAsync({
    required AppProvider provider,
    required VoidCallback onSuccess,
  }) async {
    await provider.clearDataAsync();

    onSuccess.call();
  }

  void _onLogoutSuccess(BuildContext context) {
    GoRouter.of(context).go(RouteUri.login);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Clear local user data and redirect to login screen.
      await (_doLogoutAsync(
        provider: context.read<AppProvider>(),
        onSuccess: () => _onLogoutSuccess(context),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
