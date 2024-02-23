import 'package:flutter/material.dart';
import 'package:findigitalservice/environment.dart';
import 'package:findigitalservice/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Environment.init(
    apiBaseUrl: 'https://example.com',
  );

  runApp(const RootApp());
}
