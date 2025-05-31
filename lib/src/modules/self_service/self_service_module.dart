import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../repositories/information_form/information_form_repository.dart';
import '../../repositories/information_form/information_form_repository_impl.dart';
import '../../repositories/patients/patients_repository.dart';
import '../../repositories/patients/patients_repository_impl.dart';
import 'documents/documents_page.dart';
import 'documents/scan/documents_scan_page.dart';
import 'documents/scan_confirm/documents_scan_confirm_router.dart';
import 'done/done_page.dart';
import 'find_patient/find_patient_router.dart';
import 'patient/patient_router.dart';
import 'self_service_controller.dart';
import 'self_service_page.dart';
import 'who_i_am/who_i_am_page.dart';

final class SelfServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton<InformationFormRepository>(
      (i) => InformationFormRepositoryImpl(restClient: i()),
    ),
    Bind.lazySingleton((i) => SelfServiceController(repository: i())),
    Bind.lazySingleton<PatientsRepository>(
      (i) => PatientsRepositoryImpl(restClient: i()),
    ),
  ];

  @override
  String get moduleRouteName => '/self-service';

  @override
  Map<String, WidgetBuilder> get pages => {
    '/': (_) => const SelfServicePage(),
    '/who-i-am': (_) => const WhoIAmPage(),
    '/find-patient': (_) => const FindPatientRouter(),
    '/patient': (_) => const PatientRouter(),
    '/documents': (_) => const DocumentsPage(),
    '/documents/scan': (_) => const DocumentsScanPage(),
    '/documents/scan/confirm': (_) => const DocumentsScanConfirmRouter(),
    '/done': (_) => const DonePage(),
  };
}
