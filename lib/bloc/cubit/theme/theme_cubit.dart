
import 'package:enpal/bloc/cubit/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(DarkThemeState());

  // Toggles between Light and Dark themes
  void toggleTheme() {
    if (state is LightThemeState) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }
}

