import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import '../../../models/self_service_model.dart';
import '../self_service_controller.dart';
import '../widgets/lab_clinicas_self_service_app_bar.dart';
import 'patient_controller.dart';
import 'patient_form_controller.dart';

final class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

final class _PatientPageState extends State<PatientPage>
    with PatientFormController {
  final _selfServiceController = Injector.get<SelfServiceController>();
  final _patientController = Injector.get<PatientController>();
  late final bool _patientFound;
  late final bool _enableForm;

  @override
  void initState() {
    super.initState();
    context.messageListener(_patientController);
    final SelfServiceModel(:patient) = _selfServiceController.model;
    _patientFound = patient != null;
    _enableForm = !_patientFound;
    initializeForm(patient);
    effect(() {
      if (_patientController.nextStep) {
        _selfServiceController.updatePatientAndGoToDocument(
          _patientController.patient,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasSelfServiceAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border.fromBorderSide(BorderSide(color: orangeColor)),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            width: sizeOf.width * 0.85,
            margin: const EdgeInsets.only(top: 18),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    _patientFound
                        ? 'assets/images/check_icon.png'
                        : 'assets/images/lupa_icon.png',
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _patientFound
                        ? 'Cadastro encontrado'
                        : 'Cadastro não encontrado',
                    style: titleSmallStyle,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    _patientFound
                        ? 'Confirma os dados do seu cadastro'
                        : 'Preencha os campos abaixo',
                    style: const TextStyle(
                      color: blueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: nameEc,
                    decoration: const InputDecoration(
                      label: Text('Nome do paciente'),
                    ),
                    readOnly: !_enableForm,
                    validator: Validatorless.required('Campo obrigatório'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailEc,
                    decoration: const InputDecoration(label: Text('Email')),
                    readOnly: !_enableForm,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.email('Email inválido'),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneEc,
                    decoration: const InputDecoration(
                      label: Text('Telefone de contato'),
                    ),
                    readOnly: !_enableForm,
                    validator: Validatorless.required('Campo obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: documentEc,
                    decoration: const InputDecoration(
                      label: Text('Digite o seu CPF'),
                    ),
                    readOnly: !_enableForm,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.cpf('CPF inválido'),
                    ]),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: cepEc,
                    decoration: const InputDecoration(label: Text('CEP')),
                    readOnly: !_enableForm,
                    validator: Validatorless.required('Campo obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          controller: streetEc,
                          decoration: const InputDecoration(
                            label: Text('Endereço'),
                          ),
                          readOnly: !_enableForm,
                          validator: Validatorless.required(
                            'Campo obrigatório',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: TextFormField(
                          controller: numberEc,
                          decoration: const InputDecoration(
                            label: Text('Número'),
                          ),
                          readOnly: !_enableForm,
                          validator: Validatorless.required(
                            'Campo obrigatório',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: complementEc,
                          decoration: const InputDecoration(
                            label: Text('Complemento'),
                          ),
                          readOnly: !_enableForm,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: stateEc,
                          decoration: const InputDecoration(
                            label: Text('Estado'),
                          ),
                          readOnly: !_enableForm,
                          validator: Validatorless.required(
                            'Campo obrigatório',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cityEc,
                          decoration: const InputDecoration(
                            label: Text('Cidade'),
                          ),
                          readOnly: !_enableForm,
                          validator: Validatorless.required(
                            'Campo obrigatório',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: districtEc,
                          decoration: const InputDecoration(
                            label: Text('Bairro'),
                          ),
                          readOnly: !_enableForm,
                          validator: Validatorless.required(
                            'Campo obrigatório',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: guardianEc,
                    decoration: const InputDecoration(
                      label: Text('Responsável'),
                    ),
                    readOnly: !_enableForm,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: guardianIdentificationNumberEc,
                    decoration: const InputDecoration(
                      label: Text('Identificação do responsável'),
                    ),
                    readOnly: !_enableForm,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    replacement: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () =>
                            switch (formKey.currentState?.validate()) {
                              null || false => null,
                              true => _updateOrSavePatient(),
                            },
                        child: Text(
                          !_patientFound ? 'CADASTRAR' : 'SALVAR E CONTINUAR',
                        ),
                      ),
                    ),
                    visible: !_enableForm,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => _enableForm = true),
                              child: const Text('EDITAR'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () => _patientController
                                ..patient = _selfServiceController.model.patient
                                ..goToNextStep(),
                              child: const Text('CONTINUAR'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateOrSavePatient() {
    if (_patientFound) {
      _patientController.updateAndNext(
        updatePatient(_selfServiceController.model.patient!),
      );
    } else {
      _patientController.saveAndGoToNext(createPatientRegister());
    }
  }
}
