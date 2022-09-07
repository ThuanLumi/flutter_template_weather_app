import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template_weather_app/bloc/settings_bloc/settings_bloc.dart';
import 'package:flutter_template_weather_app/bloc/theme_bloc/theme_bloc.dart';
import 'package:flutter_template_weather_app/models/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  const TemperatureWidget({Key? key, required this.weather}) : super(key: key);

  // convert celcius to fahrenheit
  int _toFahrenheit(double celcius) => ((celcius * 9 / 5) + 32).round();

  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';

  BoxedIcon _mapWeatherConditionToIcon(
      {required WeatherCondition weatherCondition}) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        return BoxedIcon(WeatherIcons.day_sunny);
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return BoxedIcon(WeatherIcons.snow);
      case WeatherCondition.heavyCloud:
        return BoxedIcon(WeatherIcons.cloud_up);
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return BoxedIcon(WeatherIcons.rain);
      case WeatherCondition.thunderstorm:
        return BoxedIcon(WeatherIcons.thunderstorm);
      case WeatherCondition.unknown:
        return BoxedIcon(WeatherIcons.sunset);
    }
    // return BoxedIcon(WeatherIcons.sunset);
  }

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mapWeatherConditionToIcon(
                weatherCondition: weather.weatherCondition),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Min Temp: ${_formattedTemperature(weather.minTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _themeState.textColor,
                        ),
                      ),
                      Text(
                        'Temp: ${_formattedTemperature(weather.temp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _themeState.textColor,
                        ),
                      ),
                      Text(
                        'Max Temp: ${_formattedTemperature(weather.maxTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: _themeState.textColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
