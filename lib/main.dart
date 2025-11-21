import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'core/common/abb_bloc_observer.dart';
import 'di/di.dart';
import 'features/easacc_scan_devices_app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // init dependency injection
  configureDependencies();

  runApp(const EasaccScanDevicesApp());
}
