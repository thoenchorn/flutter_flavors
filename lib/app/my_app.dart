import 'package:environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors/modules/page/counter_page.dart';
import 'package:theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.environment});

  final EnvironmentModel environment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnvironmentCubit>(
      create: (context) => EnvironmentCubit()..load(environment),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        builder: (you,me) => BannerWidget(child: me ?? SizedBox.shrink()),
        home: CounterPage(),
      ),
    );
  }
}
