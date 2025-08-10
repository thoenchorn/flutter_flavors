import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'provider/di/service_locator.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  static const String _logName = '🧸BlocObserver';

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log('🌟 ${bloc.runtimeType} is born! 🐣', name: _logName);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      '📬 ${bloc.runtimeType} got event 👉 ${event.runtimeType}',
      name: _logName,
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log(
      '🌈 ${bloc.runtimeType} state changed ✨\n'
      '   ├────🎀 from:    ${change.currentState}\n'
      '   └────💖 to:      ${change.nextState}',
      name: _logName,
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      '🎭 ${bloc.runtimeType} transitioned 🎬\n'
      '   🎯 Event: ${transition.event}\n'
      '   🚦 From: ${transition.currentState}\n'
      '   ➡️ To:   ${transition.nextState}',
      name: _logName,
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log(
      '💥 ${bloc.runtimeType} hit an error 😿\n🧨 $error',
      name: _logName,
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log(
      '👋 ${bloc.runtimeType} is going to sleep 😴',
      name: _logName,
    );
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  Bloc.observer = const AppBlocObserver();

  // Initialize dependencies
  await initializeDependencies();

  runApp(await builder());
}
