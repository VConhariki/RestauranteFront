import 'package:flutter/material.dart';
import 'package:flutter_application_teste/features/management/presentation/screens/management_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.white,
          primary: const Color.fromARGB(255, 18, 16, 14),
          secondary: const Color.fromARGB(255, 51, 115, 87),
          tertiary: const Color.fromARGB(255, 165, 36, 61),
        ),
        textTheme: GoogleFonts.kadwaTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: const ManagementScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
