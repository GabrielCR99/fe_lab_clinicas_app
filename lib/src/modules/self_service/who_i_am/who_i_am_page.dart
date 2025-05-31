import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

import '../self_service_controller.dart';

final class WhoIAmPage extends StatefulWidget {
  const WhoIAmPage({super.key});

  @override
  State<WhoIAmPage> createState() => _WhoIAmPageState();
}

final class _WhoIAmPageState extends State<WhoIAmPage> {
  final _controller = Injector.get<SelfServiceController>();
  final _nameEC = TextEditingController();
  final _lastNameEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onPopInvoked(bool _, Object? __) {
    _nameEC.clear();
    _lastNameEC.clear();
    _controller.clearForm();
  }

  Future<void> _onSelected(int value) async {
    if (value == 1) {
      final navigator = Navigator.of(context);
      final sp = await SharedPreferences.getInstance();
      await sp.clear();

      navigator.pushNamedAndRemoveUntil<void>('/auth/login', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvoked,
      child: Scaffold(
        appBar: LabClinicasAppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Finalizar terminal'),
                ),
              ],
              onSelected: _onSelected,
              child: const PopupIconMenu(),
            ),
          ],
        ),
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
                        const Text('Bem-vindo!', style: titleStyle),
                        const SizedBox(height: 48),
                        TextFormField(
                          controller: _nameEC,
                          decoration: const InputDecoration(
                            labelText: 'Digite seu nome',
                          ),
                          validator: Validatorless.required('Digite seu nome'),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _lastNameEC,
                          decoration: const InputDecoration(
                            labelText: 'Digite seu sobrenome',
                          ),
                          validator: Validatorless.required(
                            'Digite seu sobrenome',
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: sizeOf.width * 0.8,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () =>
                                switch (_formKey.currentState?.validate()) {
                                  null || false => null,
                                  true => _controller.setWhoIAmDataStepAndNext(
                                    name: _nameEC.text,
                                    lastName: _lastNameEC.text,
                                  ),
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
      ),
    );
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _lastNameEC.dispose();
    super.dispose();
  }
}
