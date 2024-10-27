import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../bloc/weather_bloc_bloc.dart';
import '../../widgets/image_wather_code.dart';
import '../../widgets/weather_small_icon.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: const Text('Home Screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(1, 0.3),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1, 0.3),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(color: Colors.transparent)),
                BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // success state
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.weather.areaName.toString()}📌',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Wether News of the day 📰',
                                style: GoogleFonts.oxanium(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18),
                              ),
                              ImageWatherCode(
                                  codeWeather:
                                      state.weather.weatherConditionCode!,
                                  scale: 2),
                              // const SizedBox(height: 5),
                              Center(
                                child: Text(
                                  '${state.weather.temperature!.celsius!.round()} C°',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.weather.weatherDescription
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 21),
                                ),
                              ),
                              Center(
                                child: Text(
                                  DateFormat('EEEE dd -')
                                      .add_jm()
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    WeatherSmallIcon(
                                      iconImage: 'assets/11.png',
                                      size: 8,
                                      text1: 'sunrice',
                                      text2: DateFormat('hh:mm a')
                                          .format(state.weather.sunrise!),
                                    ),
                                    WeatherSmallIcon(
                                      iconImage: 'assets/12.png',
                                      size: 8,
                                      text1: 'sunset',
                                      text2: DateFormat('hh:mm a')
                                          .format(state.weather.sunset!),
                                    ),
                                  ]),
                              // ? make the divider small
                              const Divider(
                                  color: Colors.white,
                                  thickness: 0.3,
                                  indent: 5,
                                  endIndent: 20),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherSmallIcon(
                                      iconImage: 'assets/14.png',
                                      size: 8,
                                      text1: 'Min Temp',
                                      text2:
                                          '${state.weather.tempMin!.celsius!.round()} C°'),
                                  WeatherSmallIcon(
                                    iconImage: 'assets/13.png',
                                    size: 8,
                                    text1: 'Max Temp',
                                    text2:
                                        '${state.weather.tempMax!.celsius!.round()} C°',
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    // error state
                    if (state is WeatherBlocError) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset('asset/animation/error.json'),
                              const Text("Error",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RobotoMono')),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
