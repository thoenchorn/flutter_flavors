import 'package:flutter_flavors/bootstrap.dart';
import 'package:environment/environment.dart';
import 'package:flutter_flavors/app/my_app.dart';

void main() {
  bootstrap(() {
    final environment = EnvironmentModel.uat();
    environment.logInfo();
    return MyApp(environment: environment);
  });
}
