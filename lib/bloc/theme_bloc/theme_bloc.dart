import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template_weather_app/models/weather_model.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
        )) {
    ThemeState newThemeState;
    on<ThemeEventWeatherChanged>(
      (event, emit) async {
        final weatherCondition = event.weatherCondition;
        if (weatherCondition == WeatherCondition.clear ||
            weatherCondition == WeatherCondition.lightCloud) {
          newThemeState = ThemeState(
            backgroundColor: Colors.yellow,
            textColor: Colors.black,
          );
        } else if (weatherCondition == WeatherCondition.hail ||
            weatherCondition == WeatherCondition.snow ||
            weatherCondition == WeatherCondition.sleet) {
          newThemeState = ThemeState(
            backgroundColor: Colors.lightBlue,
            textColor: Colors.white,
          );
        } else if (weatherCondition == WeatherCondition.heavyRain ||
            weatherCondition == WeatherCondition.lightRain ||
            weatherCondition == WeatherCondition.showers) {
          newThemeState = ThemeState(
            backgroundColor: Colors.indigo,
            textColor: Colors.white,
          );
        } else if (weatherCondition == WeatherCondition.thunderstorm) {
          newThemeState = ThemeState(
            backgroundColor: Colors.deepPurple,
            textColor: Colors.white,
          );
        } else {
          newThemeState = ThemeState(
            backgroundColor: Colors.lightBlue,
            textColor: Colors.white,
          );
        }
        emit(newThemeState);
      },
    );
  }
}
