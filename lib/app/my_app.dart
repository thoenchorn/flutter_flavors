import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors/bloc/environment_cubit.dart';
import 'package:flutter_flavors/config/banner_widget.dart';
import 'package:flutter_flavors/config/environment.dart';
import 'package:flutter_flavors/modules/page/counter_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.environment});

  final EnvironmentModel environment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnvironmentCubit>(
      create: (context) => EnvironmentCubit()..load(environment),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (you,me) => BannerWidget(child: me ?? SizedBox.shrink()),
        home: CounterPage(),
      ),
    );
  }
}
