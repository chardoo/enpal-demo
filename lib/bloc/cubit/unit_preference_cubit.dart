import 'package:flutter_bloc/flutter_bloc.dart';

enum UnitType { watts, kw }
class UnitPreferenceCubit extends Cubit<String> {

  UnitPreferenceCubit._internal() : super(UnitType.watts.name);

  static final UnitPreferenceCubit _instance = UnitPreferenceCubit._internal();

  factory UnitPreferenceCubit() => _instance;

  /// Toggles between 'watts' and 'kw'.
  void toggleUnit() {
    final currentUnit =  state == UnitType.watts.name ? UnitType.kw : UnitType.watts;
    emit(currentUnit.name);
  }
}
