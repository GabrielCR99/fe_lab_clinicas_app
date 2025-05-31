import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';

late final List<CameraDescription> cameras;

void main() => runZonedGuarded<void>(
  () async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    return runApp(const AppWidget());
  },
  (error, stackTrace) {
    log('runZonedGuarded: $error');
    log('runZonedGuarded: $stackTrace');

    Error.throwWithStackTrace(error, stackTrace);
  },
);
