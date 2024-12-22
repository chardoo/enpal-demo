import 'package:enpal/core/theme/theme_bloc.dart';
import 'package:enpal/core/theme/theme_event.dart';
import 'package:enpal/core/theme/theme_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
void main() {
  group('ThemeBloc Tests', () {
    late ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc();
    });

    tearDown(() {
      themeBloc.close();
    });

    test('initial state is LightThemeState', () {
      expect(themeBloc.state, isA<LightThemeState>());
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits [DarkThemeState] when ToggleThemeEvent is added while in LightThemeState',
      build: () => ThemeBloc(),
      act: (bloc) => bloc.add(ToggleThemeEvent()),
      expect: () => [isA<DarkThemeState>()],
    );

    blocTest<ThemeBloc, ThemeState>(
      'emits [LightThemeState] when ToggleThemeEvent is added while in DarkThemeState',
      build: () => ThemeBloc(),
      act: (bloc) {
        bloc.add(ToggleThemeEvent()); // First toggle to DarkThemeState
        bloc.add(ToggleThemeEvent()); // Second toggle back to LightThemeState
      },
      expect: () => [isA<DarkThemeState>(), isA<LightThemeState>()],
    );
  });
}
