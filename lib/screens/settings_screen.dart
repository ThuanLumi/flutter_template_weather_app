import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template_weather_app/bloc/language_bloc/language_bloc.dart';
import 'package:flutter_template_weather_app/bloc/light_dark_mode_bloc/light_dark_mode_bloc.dart';
import 'package:flutter_template_weather_app/bloc/settings_bloc/settings_bloc.dart';
import 'package:flutter_template_weather_app/widgets/country_dropdown_widget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingsState) {
              return ListTile(
                title: Text('Temperature Unit'),
                isThreeLine: true,
                subtitle: Text(
                  settingsState.temperatureUnit == TemperatureUnit.celsius
                      ? 'Celcius'
                      : 'Fahrenheit',
                ),
                trailing: Switch(
                  value:
                      settingsState.temperatureUnit == TemperatureUnit.celsius,
                  onChanged: (_) => BlocProvider.of<SettingsBloc>(context).add(
                    SettingsEventToggleUnit(),
                  ),
                ),
              );
            },
          ),
          BlocBuilder<LightDarkModeBloc, LightDarkModeState>(
            builder: (context, lightDarkModeState) {
              return ListTile(
                title: Text('Theme Mode'),
                isThreeLine: true,
                subtitle: Text(
                  lightDarkModeState.themeData ==
                          appThemeData[AppTheme.greenLight]
                      ? 'Light'
                      : 'Dark',
                ),
                trailing: Switch(
                  value: lightDarkModeState.themeData ==
                      appThemeData[AppTheme.greenLight],
                  onChanged: (_) =>
                      BlocProvider.of<LightDarkModeBloc>(context).add(
                    LightDarkModeEventToggle(),
                  ),
                ),
              );
            },
          ),
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              return ListTile(
                title: Text('Language'),

                // trailing: Switch(
                //   value: languageState.language == Language.english,
                //   onChanged: (_) => BlocProvider.of<LanguageBloc>(context).add(
                //     LanguageEventToggle(),
                //   ),
                // ),
                trailing: CountryDropdown(
                  countries: ['USA', 'FR'],
                  country: languageState.country,
                  onChanged: (val) =>
                      BlocProvider.of<LanguageBloc>(context).add(
                    LanguageEventToggle(country: val as String),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
