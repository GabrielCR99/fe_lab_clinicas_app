import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../models/patient_model.dart';
import '../../../repositories/patients/patients_repository.dart';

final class FindPatientController with MessagesControllerMixin {
  final _patientNotFound = Signal<bool?>(null, autoDispose: true);
  bool? get patientNotFound => _patientNotFound();

  final _patient = Signal<PatientModel?>(null, autoDispose: true);
  PatientModel? get patient => _patient();

  final PatientsRepository _patientsRepository;

  FindPatientController({required PatientsRepository patientsRepository})
    : _patientsRepository = patientsRepository;

  Future<void> findPatientByDocument(String document) async {
    final result = await _patientsRepository
        .findPatientByDocument(document)
        .asyncLoader();

    bool patientNotFound;
    PatientModel? patient;

    switch (result) {
      case Right(:final value?):
        patientNotFound = false;
        patient = value;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left():
        showError('Erro ao buscar paciente');
        return;
    }
    batch<void>(() {
      _patient.value = patient;
      _patientNotFound.set(patientNotFound, force: true);
    });
  }

  void continueWithoutDocument() => batch<void>(() {
    _patient.value = null;
    _patientNotFound.set(true, force: true);
  });
}
