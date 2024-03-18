import 'package:flutter/widgets.dart';

import '../../../models/patient_model.dart';
import '../../../repositories/patients/patients_repository.dart';
import 'patient_page.dart';

base mixin PatientFormController on State<PatientPage> {
  final formKey = GlobalKey<FormState>();
  final nameEc = TextEditingController();
  final emailEc = TextEditingController();
  final phoneEc = TextEditingController();
  final documentEc = TextEditingController();
  final cepEc = TextEditingController();
  final streetEc = TextEditingController();
  final numberEc = TextEditingController();
  final complementEc = TextEditingController();
  final stateEc = TextEditingController();
  final cityEc = TextEditingController();
  final districtEc = TextEditingController();
  final guardianEc = TextEditingController();
  final guardianIdentificationNumberEc = TextEditingController();

  void initializeForm(PatientModel? patient) {
    if (patient != null) {
      nameEc.text = patient.name;
      emailEc.text = patient.email;
      phoneEc.text = patient.phoneNumber;
      documentEc.text = patient.document;
      cepEc.text = patient.address.cep;
      streetEc.text = patient.address.streetAddress;
      numberEc.text = patient.address.number;
      complementEc.text = patient.address.complement;
      stateEc.text = patient.address.state;
      cityEc.text = patient.address.city;
      districtEc.text = patient.address.district;
      guardianEc.text = patient.guardian;
      guardianIdentificationNumberEc.text =
          patient.guardianIdentificationNumber;
    }
  }

  PatientModel updatePatient(PatientModel patient) => patient.copyWith(
        name: nameEc.text,
        email: emailEc.text,
        phoneNumber: phoneEc.text,
        document: documentEc.text,
        address: patient.address.copyWith(
          cep: cepEc.text,
          streetAddress: streetEc.text,
          number: numberEc.text,
          complement: complementEc.text,
          state: stateEc.text,
          city: cityEc.text,
          district: districtEc.text,
        ),
        guardian: guardianEc.text,
        guardianIdentificationNumber: guardianIdentificationNumberEc.text,
      );

  RegisterPatientModel createPatientRegister() => (
        name: nameEc.text,
        email: emailEc.text,
        phoneNumber: phoneEc.text,
        document: documentEc.text,
        address: (
          cep: cepEc.text,
          streetAddress: streetEc.text,
          number: numberEc.text,
          addressComplement: complementEc.text,
          state: stateEc.text,
          city: cityEc.text,
          district: districtEc.text,
        ),
        guardian: guardianEc.text,
        guardianIdentificationNumber: guardianIdentificationNumberEc.text,
      );

  @override
  void dispose() {
    nameEc.dispose();
    emailEc.dispose();
    phoneEc.dispose();
    documentEc.dispose();
    cepEc.dispose();
    streetEc.dispose();
    numberEc.dispose();
    complementEc.dispose();
    stateEc.dispose();
    cityEc.dispose();
    districtEc.dispose();
    guardianEc.dispose();
    guardianIdentificationNumberEc.dispose();
    super.dispose();
  }
}
