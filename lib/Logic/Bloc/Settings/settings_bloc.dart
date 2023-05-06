import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState.initial()) {
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<FontSizeChanged>(_onFontSizeChanged);
    on<InternationalizationChanged>(_onInternationalizationChanged);
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      switch (event.themeModeStatus) {
        case AppThemeMode.darkMode:
          emit(state.copyWith(themeModeStatus: AppThemeMode.darkMode));
          break;
        case AppThemeMode.lightMode:
          emit(state.copyWith(themeModeStatus: AppThemeMode.lightMode));
          break;
        default:
          throw Exception();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onFontSizeChanged(
    FontSizeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(fontSizeSliderValue: event.sliderValue));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onInternationalizationChanged(
    InternationalizationChanged event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(internationalization: event.internationalization));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
