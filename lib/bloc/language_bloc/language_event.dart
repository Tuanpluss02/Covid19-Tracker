part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  final Locale locale;
  const LanguageEvent(this.locale);
  @override
  List<Object> get props => [locale];
}

class ChangeLanguageToVi extends LanguageEvent {
  const ChangeLanguageToVi() : super(const Locale('vi', 'VN'));
}

class ChangeLanguageToEn extends LanguageEvent {
  const ChangeLanguageToEn() : super(const Locale('en', 'US'));
}
