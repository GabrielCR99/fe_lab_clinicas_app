import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import 'find_patient_controller.dart';
import 'find_patient_page.dart';

final class FindPatientRouter extends FlutterGetItModulePageRouter {
  const FindPatientRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton((i) => FindPatientController(patientsRepository: i())),
  ];

  @override
  WidgetBuilder get view =>
      (_) => const FindPatientPage();
}
