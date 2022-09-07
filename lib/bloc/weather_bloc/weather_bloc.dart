import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template_weather_app/models/weather_model.dart';
import 'package:flutter_template_weather_app/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : super(WeatherStateInitial()) {
    on<WeatherEventRequested>(
      (event, emit) async {
        emit(WeatherStateLoading());
        try {
          final Weather weather =
              await weatherRepository.getWeatherFromCity(event.city);
          emit(WeatherStateSuccess(weather: weather));
        } catch (exception) {
          emit(WeatherStateFailure());
        }
      },
    );

    on<WeatherEventRefresh>(
      (event, emit) async {
        try {
          final Weather weather =
              await weatherRepository.getWeatherFromCity(event.city);
          emit(WeatherStateSuccess(weather: weather));
        } catch (exception) {
          emit(WeatherStateFailure());
        }
      },
    );
  }
}
