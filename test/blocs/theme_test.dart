import 'package:enpal/bloc/theme/theme_cubit.dart';
import 'package:enpal/bloc/theme/theme_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
void main() {
  group('ThemeBloc Tests', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state is LightThemeState', () {
      expect(themeCubit.state, isA<LightThemeState>());
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits [DarkThemeState] when ToggleThemeEvent is added while in LightThemeState',
      build: () => ThemeCubit(),
      act: (bloc) => bloc.toggleTheme(),
      expect: () => [isA<DarkThemeState>()],
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits [LightThemeState] when ToggleThemeEvent is added while in DarkThemeState',
      build: () => ThemeCubit(),
      act: (bloc) {
        bloc.toggleTheme(); // First toggle to DarkThemeState
        bloc.toggleTheme(); // Second toggle back to LightThemeState
      },
      expect: () => [isA<DarkThemeState>(), isA<LightThemeState>()],
    );
  });
}
