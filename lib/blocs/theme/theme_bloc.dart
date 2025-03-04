import 'package:bloc/bloc.dart';

import '../../config/themes.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeMode: ThemeModes.dark, themeData: darkTheme)) {
    on<ToggleTheme>(_onToggleTheme);
    on<InitTheme>(_onInitTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    if (state.themeMode == ThemeModes.dark) {
      emit(state.copyWith(themeMode: ThemeModes.light, themeData: lightTheme));
    } else {
      emit(state.copyWith(themeMode: ThemeModes.dark, themeData: darkTheme));
    }
  }

  void _onInitTheme(InitTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: ThemeModes.dark, themeData: darkTheme));
  }
}
