import 'package:flutter/material.dart';
import 'package:saved/environment.dart';
import 'package:saved/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Environment.init(
    apiBaseUrl: 'https://example.com',
  );

  runApp(const RootApp());
}
