part of 'light_dark_mode_bloc.dart';

enum AppTheme {
  greenLight,
  greenDark,
  // blueLight,
  // blueDark,
}

final appThemeData = {
  AppTheme.greenLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
  ),
  AppTheme.greenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
  ),
  // AppTheme.blueLight: ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: Colors.blue,
  // ),
  // AppTheme.blueDark: ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.blue[700],
  // ),
};

class LightDarkModeState extends Equatable {
  final ThemeData? themeData;

  const LightDarkModeState({required this.themeData});

  @override
  List<Object?> get props => [themeData];
}
