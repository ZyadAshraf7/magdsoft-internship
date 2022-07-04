import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'localize_state.dart';

class LocalizeCubit extends Cubit<LocalizeState> {
  LocalizeCubit() : super(SelectedLanguage(const Locale('en')));

  void translateToArabic() => emit(SelectedLanguage(const Locale('ar')));

  void translateToEnglish() => emit(SelectedLanguage(const Locale('en')));
}
