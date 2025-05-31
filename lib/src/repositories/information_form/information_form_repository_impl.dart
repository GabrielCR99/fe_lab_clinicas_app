// ignore_for_file: unnecessary_null_checks

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_model.dart';
import '../../models/self_service_model.dart';
import './information_form_repository.dart';

final class InformationFormRepositoryImpl implements InformationFormRepository {
  final RestClient restClient;

  const InformationFormRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, Unit>> register(
    SelfServiceModel model,
  ) async {
    try {
      final SelfServiceModel(
        :name,
        :lastName,
        patient: PatientModel(id: patientId)!,
        documents: {
          DocumentType.healthInsuranceCard: List(first: healthInsuranceCardDoc),
          DocumentType.medicalOrder: medicalOrderDocs,
        }!,
      ) = model;

      await restClient.post<void>(
        '/patientInformationForm',
        data: {
          'patient_id': patientId,
          'health_insurance_card': healthInsuranceCardDoc,
          'medical_order': medicalOrderDocs,
          'password': '$name $lastName',
          'date_created': DateTime.now().toIso8601String(),
          'status': 'Waiting',
          'tests': const <Object>[],
        },
      );

      return const Right(unit);
    } on DioException catch (e, s) {
      log(
        'Erro ao finalizar formulário de auto atendimento',
        error: e,
        stackTrace: s,
      );

      return const Left(RepositoryException());
    }
  }
}
