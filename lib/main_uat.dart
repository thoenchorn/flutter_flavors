import 'dart:developer';
import 'package:flutter_flavors/bootstrap.dart';
import 'package:flutter_flavors/config/environment.dart';
import 'package:flutter_flavors/app/my_app.dart';

void main() {
  bootstrap(() {
    final environment = EnvironmentModel.uat();
    log('     🔬 ${environment.baseUrl}\n',name: '🌐URL UAT');
    return MyApp(environment: environment);
  });
}
