import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'http.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dio.interceptors.add(LogInterceptor());
  runApp(const App());
}
