import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_flavors/config/environment.dart';
import 'package:flutter_flavors/enum/status_cubit.dart';
part 'environment_state.dart';

class EnvironmentCubit extends Cubit<EnvironmentState> {
  EnvironmentCubit() : super(const EnvironmentState());

  void load(EnvironmentModel env) {
    emit(state.copyWith(status: Status.success, environment: env));
  }
}
