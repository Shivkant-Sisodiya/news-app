import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/blocs/app_theme/Repository/app_themes.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc()
      : super(
          AppThemeState(theme: AppTheme.lightTheme),
        );
  @override
  Stream<AppThemeState> mapEventToState(
    AppThemeEvent event,
  ) async* {
    if (event is AppThemeEvent) {
      yield AppThemeState(theme: event.theme);
    }
  }
}
