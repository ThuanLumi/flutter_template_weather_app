import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'light_dark_mode_event.dart';
part 'light_dark_mode_state.dart';

class LightDarkModeBloc extends Bloc<LightDarkModeEvent, LightDarkModeState> {
  LightDarkModeBloc()
      : super(
          LightDarkModeState(themeData: appThemeData[AppTheme.greenLight]),
        ) {
    on<LightDarkModeEventToggle>(
      (event, emit) async {
        emit(
          LightDarkModeState(
            themeData: state.themeData == appThemeData[AppTheme.greenLight]
                ? appThemeData[AppTheme.greenDark]
                : appThemeData[AppTheme.greenLight],
          ),
        );
      },
    );
  }
}
