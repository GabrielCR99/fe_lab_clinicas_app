import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'main.dart';
import 'src/bindings/lab_clinicas_application_binding.dart';
import 'src/modules/auth/auth_module.dart';
import 'src/modules/self_service/self_service_module.dart';
import 'src/pages/home/home_page.dart';
import 'src/pages/splash_page/splash_page.dart';

final class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      bindings: LabClinicasApplicationBinding(),
      pageBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/'),
        FlutterGetItPageBuilder(page: (_) => const HomePage(), path: '/home'),
      ],
      modules: [AuthModule(), SelfServiceModule()],
      title: 'Lab Clínicas auto atendimento',
      onInit: () => FlutterGetItBindingRegister.registerPermanentBinding(
        'CAMERAS',
        [Bind.lazySingleton((_) => cameras)],
      ),
    );
  }
}
