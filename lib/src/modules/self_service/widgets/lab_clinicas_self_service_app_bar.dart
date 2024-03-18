import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../self_service_controller.dart';

final class LabClinicasSelfServiceAppBar extends LabClinicasAppBar {
  LabClinicasSelfServiceAppBar({super.key})
      : super(
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Reiniciar processo'),
                ),
              ],
              onSelected: (_) =>
                  Injector.get<SelfServiceController>().restartProcess(),
              child: const PopupIconMenu(),
            ),
          ],
        );
}
