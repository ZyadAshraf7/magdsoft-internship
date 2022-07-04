part of 'localize_cubit.dart';

@immutable
abstract class LocalizeState {
  final Locale locale;
  const LocalizeState(this.locale);
}

class SelectedLanguage extends LocalizeState {
  SelectedLanguage(Locale locale) : super(locale);
}
