import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/patient_model.dart';
import '../../models/self_service_model.dart';
import '../../repositories/information_form/information_form_repository.dart';

enum FormSteps { none, whoIAm, findPatient, patient, documents, done, restart }

final class SelfServiceController with MessagesControllerMixin {
  var password = '';

  final _step = signal(FormSteps.none, autoDispose: true);
  FormSteps get step => _step();
  var _model = const SelfServiceModel();
  SelfServiceModel get model => _model;

  final InformationFormRepository _repository;

  SelfServiceController({required InformationFormRepository repository})
    : _repository = repository;

  void startProcess() => _step.set(FormSteps.whoIAm);

  void setWhoIAmDataStepAndNext({
    required String name,
    required String lastName,
  }) {
    _model = _model.copyWith(name: () => name, lastName: () => lastName);
    _step.set(FormSteps.findPatient, force: true);
  }

  void clearForm() => _model = _model.clear();

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.set(FormSteps.patient, force: true);
  }

  void restartProcess() {
    _step.set(FormSteps.restart, force: true);
    clearForm();
  }

  void updatePatientAndGoToDocument(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.set(FormSteps.documents, force: true);
  }

  void registerDocument(DocumentType type, String filePath) {
    final documents = _model.documents ?? {};

    if (type == DocumentType.healthInsuranceCard) {
      documents[type]?.clear();
    }

    final values = (documents[type] ?? [])..add(filePath);
    documents[type] = values;
    _model = _model.copyWith(documents: () => documents);
  }

  void clearDocuments() => _model = _model.copyWith(documents: () => const {});

  Future<void> finishProcess() async {
    final result = await _repository.register(_model).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao finalizar formulário de auto atendimento');
      case Right():
        password = '${_model.name} ${_model.lastName}';
        _step.set(FormSteps.done, force: true);
    }
  }
}
