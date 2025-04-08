import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/app.dart';
import 'core/storage/shared_preferences_async.dart';
import 'init_dependencies.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    usePathUrlStrategy();
  }
  
  await initDependencies();

  await SharedPreferencesAsync.instance.clear();
  
  runApp(const App());
}