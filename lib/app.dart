import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/theme/theme_event.dart';
import 'blocs/theme/theme_state.dart';
import 'injection_container.dart' as di;
import 'screens/trading_screen.dart';

class TradingApp extends StatelessWidget {
  const TradingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ThemeBloc>()..add(InitTheme()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Sisyphus Trading',
            theme: themeState.themeData,
            home: const TradingPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}