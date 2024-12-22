
import 'package:enpal/core/theme/theme_event.dart';
import 'package:enpal/core/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>((event, emit) {
      if (state is LightThemeState) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }
}
