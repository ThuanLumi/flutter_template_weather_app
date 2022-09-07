import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template_weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:flutter_template_weather_app/screens/city_search_screen.dart';
import 'package:flutter_template_weather_app/screens/settings_screen.dart';
import 'package:flutter_template_weather_app/widgets/temperature_widget.dart';

import '../bloc/theme_bloc/theme_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Completer<void>? _completer;

  @override
  void initState() {
    _completer = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              //Navigate to setting screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () async {
              //Navigate to city search screen
              final typedCity = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CitySearchScreen(),
                ),
              );
              BlocProvider.of<WeatherBloc>(context).add(
                WeatherEventRequested(city: typedCity),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(
                ThemeEventWeatherChanged(
                    weatherCondition: weatherState.weather.weatherCondition),
              );
              _completer?.complete();
              _completer = Completer();
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                        WeatherEventRefresh(city: weather.location),
                      );
                      return _completer!.future;
                    },
                    child: Container(
                      color: themeState.backgroundColor,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Text(
                                weather.location,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: themeState.textColor,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Center(
                                child: Text(
                                  'Updated: ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: themeState.textColor,
                                  ),
                                ),
                              ),
                              TemperatureWidget(weather: weather),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (weatherState is WeatherStateFailure) {
              return const Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16.0,
                ),
              );
            }
            return const Text(
              'Select a location first!',
              style: TextStyle(fontSize: 30.0),
            );
          },
        ),
      ),
    );
  }
}
