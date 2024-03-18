import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_model.dart';
import 'patients_repository.dart';

final class PatientsRepositoryImpl implements PatientsRepository {
  final RestClient restClient;

  const PatientsRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
    String document,
  ) async {
    try {
      final Response(:data) = await restClient.auth.get<List<Object?>>(
        '/patients',
        queryParameters: {'document': document},
      );

      if (data?.isEmpty ?? false) {
        return const Right(null);
      }

      return Right(PatientModel.fromJson(data!.first! as Map<String, dynamic>));
    } on DioException catch (e, s) {
      log('Erro ao buscar paciente por cpf', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> update(PatientModel patient) async {
    try {
      await restClient.auth
          .put<void>('/patients/${patient.id}', data: patient.toJson());

      return const Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar paciente', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, PatientModel>> register(
    RegisterPatientModel patient,
  ) async {
    try {
      final Response(:data) = await restClient.auth.post<Map<String, dynamic>>(
        '/patients',
        data: {
          'name': patient.name,
          'email': patient.email,
          'document': patient.document,
          'phone_number': patient.phoneNumber,
          'address': {
            'cep': patient.address.cep,
            'street_address': patient.address.streetAddress,
            'number': patient.address.number,
            'address_complement': patient.address.addressComplement,
            'state': patient.address.state,
            'city': patient.address.city,
            'district': patient.address.district,
          },
          'guardian': patient.guardian,
          'guardian_identification_number':
              patient.guardianIdentificationNumber,
        },
      );

      return Right(PatientModel.fromJson(data ?? const {}));
    } on DioException catch (e, s) {
      log('Erro ao atualizar paciente', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }
}
