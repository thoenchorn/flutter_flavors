import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../environment.dart';
part 'environment_state.dart';

class EnvironmentCubit extends Cubit<EnvironmentState> {
  EnvironmentCubit() : super(const EnvironmentState());

  void load(EnvironmentModel env) {
    emit(state.copyWith(status: Status.success, environment: env));
  }
}
