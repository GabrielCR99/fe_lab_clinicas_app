import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'self_service_controller.dart';

final class SelfServicePage extends StatefulWidget {
  const SelfServicePage({super.key});

  @override
  State<SelfServicePage> createState() => _SelfServicePageState();
}

final class _SelfServicePageState extends State<SelfServicePage> {
  final _controller = Injector.get<SelfServiceController>();

  @override
  void initState() {
    super.initState();
    _controller.startProcess();
    scheduleMicrotask(
      () => effect(() {
        final navigator = Navigator.of(context);
        var baseRoute = '/self-service/';
        final step = _controller.step;

        switch (step) {
          case FormSteps.none:
            return;
          case FormSteps.whoIAm:
            baseRoute += 'who-i-am';
          case FormSteps.findPatient:
            baseRoute += 'find-patient';
          case FormSteps.patient:
            baseRoute += 'patient';
          case FormSteps.documents:
            baseRoute += 'documents';
          case FormSteps.done:
            baseRoute += 'done';
          case FormSteps.restart:
            navigator.popUntil(ModalRoute.withName('/self-service'));
            _controller.startProcess();
            return;
        }

        navigator.pushNamed<void>(baseRoute);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
