part of 'environment_cubit.dart';

enum Status {
  initial,
  loading,
  success
}
class EnvironmentState extends Equatable {
  const EnvironmentState({
    this.status = Status.initial,
    this.message,
    this.environment,
  });

  final Status status;
  final String? message;
  final EnvironmentModel? environment;

  EnvironmentState copyWith({
    Status? status,
    String? message,
    EnvironmentModel? environment,
  }) {
    return EnvironmentState(
      status: status ?? this.status,
      message: message ?? this.message,
      environment: environment ?? this.environment,
    );
  }

  @override
  List<Object?> get props => [status, message, environment];

}
