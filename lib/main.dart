import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template_weather_app/bloc/language_bloc/language_bloc.dart';
import 'package:flutter_template_weather_app/bloc/light_dark_mode_bloc/light_dark_mode_bloc.dart';
import 'package:flutter_template_weather_app/bloc/settings_bloc/settings_bloc.dart';
import 'package:flutter_template_weather_app/bloc/theme_bloc/theme_bloc.dart';
import 'package:flutter_template_weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:flutter_template_weather_app/repositories/weather_repository.dart';
import 'package:flutter_template_weather_app/screens/weather_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider<LightDarkModeBloc>(
          create: (context) => LightDarkModeBloc(),
        ),
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc(),
        ),
      ],
      child: MyApp(
        weatherRepository: weatherRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const MyApp({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightDarkModeBloc, LightDarkModeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Flutter Weather App with Bloc',
          theme: themeState.themeData,
          home: BlocProvider<WeatherBloc>(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepository),
            child: WeatherScreen(),
          ),
        );
      },
    );
  }
}
