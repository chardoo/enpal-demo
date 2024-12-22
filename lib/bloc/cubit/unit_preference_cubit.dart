import 'package:flutter_bloc/flutter_bloc.dart';

class UnitPreferenceCubit extends Cubit<String> {

  UnitPreferenceCubit._internal() : super('watts');

  static final UnitPreferenceCubit _instance = UnitPreferenceCubit._internal();

  factory UnitPreferenceCubit() => _instance;

  /// Toggles between 'watts' and 'kw'.
  void toggleUnit() {
    emit(state == 'watts' ? 'kw' : 'watts');
  }
}
