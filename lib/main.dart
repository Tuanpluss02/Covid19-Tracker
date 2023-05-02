import 'package:covid19_tracker/bloc/language_bloc/language_bloc.dart';
import 'package:covid19_tracker/generated/l10n.dart';
import 'package:covid19_tracker/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageBloc(),
      child: BlocListener<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is LanguageChanged) {
            debugPrint('Language changed to ${state.locale} in main ');
            S.load(state.locale);
          }
        },
        child: MaterialApp(
          locale: const Locale('en', 'US'),
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
        ),
      ),
    );
  }
}
