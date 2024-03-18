import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_model.dart';

typedef _RegisterPatientAddressModel = ({
  String cep,
  String streetAddress,
  String number,
  String addressComplement,
  String state,
  String city,
  String district,
});

typedef RegisterPatientModel = ({
  String name,
  String email,
  String phoneNumber,
  String document,
  _RegisterPatientAddressModel address,
  String guardian,
  String guardianIdentificationNumber,
});

abstract interface class PatientsRepository {
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
    String document,
  );
  Future<Either<RepositoryException, Unit>> update(PatientModel patient);
  Future<Either<RepositoryException, PatientModel>> register(
    RegisterPatientModel patient,
  );
}
