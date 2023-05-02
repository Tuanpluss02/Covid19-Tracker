import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageInitial(Locale('en', 'US'))) {
    on<ChangeLanguageVi>((event, emit) async {
      try {
        debugPrint('Language changed to Vi $state');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('lang', 'vi');
        emit(const LanguageChanged(Locale('vi', 'VN')));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<ChangeLanguageEn>((event, emit) async {
      try {
        debugPrint('Language changed to En $state');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('lang', 'en');
        emit(const LanguageChanged(Locale('en', 'US')));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
