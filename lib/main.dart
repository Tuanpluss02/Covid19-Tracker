import 'package:covid19_tracker/generated/l10n.dart';
import 'package:covid19_tracker/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

var language = const Locale('en', 'US');
Future<void> main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? lang = prefs.getString('lang');
  if (lang != null) {
    language =
        (lang == 'en') ? const Locale('en', 'US') : const Locale('vi', 'VN');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: language,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}
