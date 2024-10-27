import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../constants/string.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        final weatherGet = WeatherFactory(API_KEY, language: Language.ENGLISH);
        print('Weather: $weatherGet');
        log('Weather: $weatherGet');

        // if(lc ==null ){
        //   lc =Position()
        // }
        final weatherG = await weatherGet.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );

        log('Weather: ${weatherG.temperature}');

        emit(WeatherBlocSuccess(weather: weatherG));
      } catch (e) {
        emit(WeatherBlocError());
      }
    });
  }
}
