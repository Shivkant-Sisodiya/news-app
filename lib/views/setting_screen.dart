import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/blocs/app_theme/app_theme_bloc.dart';
import 'package:flutter_news_app/settings/app_themes.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    print(isDarkMode);
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: BlocBuilder<AppThemeBloc, AppThemeState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    BlocProvider.of<AppThemeBloc>(context)
                        .add(AppThemeEvent(theme: AppTheme.lightTheme));
                  },
                  child: Text('Light'),
                ),
                FlatButton(
                  onPressed: () {
                    BlocProvider.of<AppThemeBloc>(context)
                        .add(AppThemeEvent(theme: AppTheme.darkTheme));
                  },
                  child: Text('Dark'),
                ),
                FlatButton(
                  onPressed: () {
                    if (isDarkMode) {
                      BlocProvider.of<AppThemeBloc>(context)
                          .add(AppThemeEvent(theme: AppTheme.darkTheme));
                    } else {
                      BlocProvider.of<AppThemeBloc>(context)
                          .add(AppThemeEvent(theme: AppTheme.lightTheme));
                    }
                  },
                  child: Text('System'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
