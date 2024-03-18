import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../self_service_controller.dart';

final class DonePage extends StatelessWidget {
  const DonePage({super.key});

  static final _selfServiceController = Injector.get<SelfServiceController>();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Align(
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
              child: Column(
                children: [
                  Image.asset('assets/images/stroke_check.png'),
                  const SizedBox(height: 15),
                  const Text('Sua senha é', style: titleSmallStyle),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: orangeColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 218, minHeight: 48),
                    child: Text(
                      _selfServiceController.password,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: 'Aguarde!\n'),
                        TextSpan(text: 'Sua senha será chamada no painel'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            // TODO(roveri): Create a method to print password
                            onPressed: UnimplementedError.new,
                            child: Text('IMPRIMIR SENHA'),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            // TODO(roveri): Create a method to send password via SMS
                            onPressed: UnimplementedError.new,
                            child: Text('ENVIAR SENHA VIA SMS'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _selfServiceController.restartProcess,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orangeColor,
                      ),
                      child: const Text(
                        'FINALIZAR',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}
