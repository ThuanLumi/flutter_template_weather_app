import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(temperatureUnit: TemperatureUnit.celsius)) {
    on<SettingsEventToggleUnit>(
      (event, emit) async {
        final newSettingsState = SettingsState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius,
        );
        emit(newSettingsState);
      },
    );
  }
}
