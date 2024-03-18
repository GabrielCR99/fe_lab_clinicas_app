import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import '../self_service_controller.dart';
import '../widgets/lab_clinicas_self_service_app_bar.dart';
import 'find_patient_controller.dart';

final class FindPatientPage extends StatefulWidget {
  const FindPatientPage({super.key});

  @override
  State<FindPatientPage> createState() => _FindPatientPageState();
}

final class _FindPatientPageState extends State<FindPatientPage> {
  final _controller = Injector.get<FindPatientController>();
  final _selfServiceController = Injector.get<SelfServiceController>();
  final _cpfEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.messageListener(_controller);
    effect(() {
      final FindPatientController(:patient, :patientNotFound) = _controller;

      if (patient != null || patientNotFound != null) {
        _selfServiceController.goToFormPatient(patient);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasSelfServiceAppBar(),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_login.png'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                width: sizeOf.width * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo_vertical.png'),
                      const SizedBox(height: 48),
                      TextFormField(
                        controller: _cpfEC,
                        decoration: const InputDecoration(
                          labelText: 'Digite o CPF do paciente',
                        ),
                        validator: Validatorless.cpf('CPF inválido'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Flexible(
                            child: Text(
                              'Não sabe o CPF do paciente?',
                              style: TextStyle(
                                color: blueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: _controller.continueWithoutDocument,
                              child: const Text(
                                'Clique aqui',
                                style: TextStyle(
                                  color: orangeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: sizeOf.width * 0.8,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () =>
                              switch (_formKey.currentState?.validate()) {
                            null || false => null,
                            true =>
                              _controller.findPatientByDocument(_cpfEC.text),
                          },
                          child: const Text('CONTINUAR'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cpfEC.dispose();
    super.dispose();
  }
}
