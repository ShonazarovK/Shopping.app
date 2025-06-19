import 'package:flutter/material.dart';

import 'app.dart';
import 'bloc_provider.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MyBlocProvider(child: MyApp()));
}
