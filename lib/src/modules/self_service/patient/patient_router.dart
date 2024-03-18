import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'patient_controller.dart';
import 'patient_page.dart';

final class PatientRouter extends FlutterGetItModulePageRouter {
  const PatientRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => PatientController(patientsRepository: i())),
      ];
  @override
  WidgetBuilder get view => (_) => const PatientPage();
}
