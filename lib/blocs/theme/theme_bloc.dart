import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class SetThemeMode extends ThemeEvent {
  final ThemeMode themeMode;
  SetThemeMode(this.themeMode);
}

// State
class ThemeState {
  final ThemeMode themeMode;

  ThemeState({this.themeMode = ThemeMode.system});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<ToggleTheme>((event, emit) {
      final newMode = state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
      emit(state.copyWith(themeMode: newMode));
    });

    on<SetThemeMode>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });
  }
} 