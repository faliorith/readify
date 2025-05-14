import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final Locale locale;
  ChangeLanguage(this.locale);
}

// State
class LanguageState {
  final Locale locale;

  LanguageState({this.locale = const Locale('en')});

  LanguageState copyWith({Locale? locale}) {
    return LanguageState(
      locale: locale ?? this.locale,
    );
  }
}

// Bloc
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState()) {
    on<ChangeLanguage>((event, emit) {
      emit(state.copyWith(locale: event.locale));
    });
  }
} 