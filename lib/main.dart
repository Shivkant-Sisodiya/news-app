import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/blocs/app_theme/app_theme_bloc.dart';

import 'package:flutter_news_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter_news_app/blocs/sign_in/sign_in_Screen.dart';
import 'package:flutter_news_app/repositories/geolocation_repository.dart';
import 'package:flutter_news_app/repositories/new_news_repository.dart';

import 'blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'blocs/new_news_bloc/new_news_bloc.dart';
import 'blocs/newsbloc/news_bloc.dart';
import 'blocs/newsbloc/news_states.dart';
import 'blocs/search/search_bloc.dart';
import 'blocs/sign_in/sign_in_bloc.dart';
import 'repositories/news_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchBloc(
              searchRepository: NewsRepository(),
            ),
          ),
          BlocProvider(
              create: (context) => GeolocationBloc(
                  geolocationRepository: context.read<GeolocationRepository>())
                ..add(LoadGeolocation())),
          BlocProvider<NewsBloc>(
            create: (context) => NewsBloc(
                initialState: NewsInitState(),
                newsRepositoty: NewsRepository()),
          ),
          BlocProvider<NewNewsBloc>(
            create: (context) => NewNewsBloc(
                initialState: NewNewsInitState(),
                newsRepositoty: NewNewsRepository()),
          ),
          BlocProvider<AppThemeBloc>(
            create: (context) => AppThemeBloc(),
          ),
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(),
          ),
          BlocProvider<BottomNavigationBloc>(
            create: (context) => BottomNavigationBloc()..add(AppStarted()),
          ),
        ],
        child: BlocBuilder<AppThemeBloc, AppThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.theme,
              home: SignInScreen(),
            );
          },
        ),
      ),
    );
  }
}
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<NewsBloc>(
//           create: (context) => NewsBloc(
//               initialState: NewsInitState(), newsRepositoty: NewsRepository()),
//         )
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//             scaffoldBackgroundColor: Colors.white,
//             textTheme: GoogleFonts.poppinsTextTheme(
//               Theme.of(context).textTheme,
//             )),
//         home: HomeScreen(),
//       ),
//     );
//   }
// }
