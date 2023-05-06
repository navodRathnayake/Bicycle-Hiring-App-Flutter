part of 'settings_bloc.dart';

enum AppThemeMode { lightMode, darkMode }

enum AppInternatinalization { english, sinhala, tamil }

@immutable
class SettingsState extends Equatable {
  final AppThemeMode themeModeStatus;
  final double fontSizeSliderValue;
  final Set<dynamic> internationalization;

  const SettingsState({
    required this.themeModeStatus,
    required this.fontSizeSliderValue,
    required this.internationalization,
  });

  const SettingsState._(
      {this.themeModeStatus = AppThemeMode.lightMode,
      this.fontSizeSliderValue = 33.333,
      this.internationalization = const <AppInternatinalization>{
        AppInternatinalization.english
      }});

  const SettingsState.initial() : this._();

  SettingsState copyWith({
    AppThemeMode? themeModeStatus,
    double? fontSizeSliderValue,
    Set<dynamic>? internationalization,
  }) {
    return SettingsState(
        themeModeStatus: themeModeStatus ?? this.themeModeStatus,
        fontSizeSliderValue: fontSizeSliderValue ?? this.fontSizeSliderValue,
        internationalization:
            internationalization ?? this.internationalization);
  }

  @override
  List<Object?> get props =>
      [themeModeStatus, fontSizeSliderValue, internationalization];
}
