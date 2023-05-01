import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageInitial(Locale('en', 'US'))) {
    on<ChangeLanguageToVi>((event, emit) {
      debugPrint('Language changed to ${event.locale}');
      emit(LanguageChanged(event.locale));
    });
    on<ChangeLanguageToEn>((event, emit) {
      debugPrint('Language changed to ${event.locale}');
      emit(LanguageChanged(event.locale));
    });
  }
}
