import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../models/patient_model.dart';
import '../../../repositories/patients/patients_repository.dart';

final class PatientController with MessagesControllerMixin {
  PatientModel? patient;

  final _nextStep = signal(false, autoDispose: true);
  bool get nextStep => _nextStep();

  final PatientsRepository _patientsRepository;

  PatientController({required PatientsRepository patientsRepository})
      : _patientsRepository = patientsRepository;

  void goToNextStep() => _nextStep.value = true;

  Future<void> updateAndNext(PatientModel model) async {
    final result = await _patientsRepository.update(model);

    switch (result) {
      case Left():
        showError('Erro ao atualizar paciente');
      case Right():
        showSuccess('Paciente atualizado com sucesso');
        patient = model;
        goToNextStep();
    }
  }

  Future<void> saveAndGoToNext(
    RegisterPatientModel registerPatientModel,
  ) async {
    final result =
        await _patientsRepository.register(registerPatientModel).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao cadastrar paciente');
      case Right(:final value):
        showInfo('Paciente cadastrado com sucesso');
        patient = value;
        goToNextStep();
    }
  }
}
