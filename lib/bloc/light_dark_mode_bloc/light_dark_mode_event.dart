part of 'light_dark_mode_bloc.dart';

abstract class LightDarkModeEvent extends Equatable {
  const LightDarkModeEvent();
}

class LightDarkModeEventToggle extends LightDarkModeEvent {
  @override
  List<Object> get props => [];
}
