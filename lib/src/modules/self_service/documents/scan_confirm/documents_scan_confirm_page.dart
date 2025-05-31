import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../widgets/lab_clinicas_self_service_app_bar.dart';
import 'documents_scan_confirm_controller.dart';

final class DocumentsScanConfirmPage extends StatefulWidget {
  const DocumentsScanConfirmPage({super.key});

  @override
  State<DocumentsScanConfirmPage> createState() =>
      _DocumentsScanConfirmPageState();
}

final class _DocumentsScanConfirmPageState
    extends State<DocumentsScanConfirmPage> {
  static final _controller = Injector.get<DocumentsScanConfirmController>();

  @override
  void initState() {
    super.initState();
    _controller.pathRemoteStorage.addListener(
      () => Navigator.of(context)
        ..pop<void>()
        ..pop<String?>(_controller.pathRemoteStorage.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final photo = ModalRoute.of(context)?.settings.arguments as XFile?;

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
            child: Column(
              children: [
                Image.asset('assets/images/foto_confirm_icon.png'),
                const SizedBox(height: 15),
                const Text('CONFIRE A SUA FOTO', style: titleSmallStyle),
                const SizedBox(height: 32),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: SizedBox(
                    width: sizeOf.width * 0.5,
                    child: DottedBorder(
                      options: const RoundedRectDottedBorderOptions(
                        color: orangeColor,
                        strokeWidth: 4,
                        dashPattern: [1, 10, 1, 3],
                        radius: Radius.circular(16),
                        strokeCap: StrokeCap.square,
                      ),
                      child: Image.file(File(photo?.path ?? '')),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: Navigator.of(context).pop,
                          child: const Text('Tirar outra'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => _saveImage(photo),
                          child: const Text('SALVAR'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveImage(XFile? photo) async {
    final imageBytes = await photo?.readAsBytes();
    final fileName = photo?.name;
    await _controller.uploadImage(
      imageBytes: imageBytes ?? Uint8List(0),
      fileName: fileName ?? '',
    );
  }
}
