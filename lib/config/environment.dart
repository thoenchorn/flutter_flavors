
import 'package:flutter/material.dart';

enum Environment { development, staging, uat, production }

class EnvironmentModel {
  const EnvironmentModel({
    required this.color,
    required this.baseUrl,
    required this.appVersion,
    required this.environment,
    required this.name,
  });

  factory EnvironmentModel.production({
    Color? color,
    String? baseUrl,
    String? appVersion,
    Environment? environment,
    String? name,
  }) {
    return EnvironmentModel(
      color: color ?? Colors.transparent,
      baseUrl: baseUrl ?? 'http://example_bass/api/v1',
      appVersion: appVersion ?? 'v1',
      environment: environment ?? Environment.production,
      name: name ?? '',
    );
  }

  factory EnvironmentModel.development({
    Color? color,
    String? baseUrl,
    String? appVersion,
    Environment? environment,
    String? name,
  }) {
    return EnvironmentModel(
      color: color ?? Colors.red,
      baseUrl: baseUrl ?? 'http://example_bass/api/v1/dev',
      appVersion: appVersion ?? 'v1',
      environment: environment ?? Environment.development,
      name: name ?? 'DEV',
    );
  }

  factory EnvironmentModel.staging({
    Color? color,
    String? baseUrl,
    String? appVersion,
    Environment? environment,
    String? name,
  }) {
    return EnvironmentModel(
      color: color ?? Colors.orangeAccent,
      baseUrl: baseUrl ?? 'http://example_bass/api/v1/stg',
      appVersion: appVersion ?? 'v1',
      environment: environment ?? Environment.staging,
      name: name ?? 'STG',
    );
  }

  factory EnvironmentModel.uat({
    Color? color,
    String? baseUrl,
    String? appVersion,
    Environment? environment,
    String? name,
  }) {
    return EnvironmentModel(
      color: color ?? Colors.blueAccent,
      baseUrl: baseUrl ?? 'http://example_bass/api/v1/uat',
      appVersion: appVersion ?? 'v1',
      environment: environment ?? Environment.uat,
      name: name ?? 'UAT',
    );
  }

  final Color color;
  final String baseUrl;
  final String appVersion;
  final Environment environment;
  final String name;
}
