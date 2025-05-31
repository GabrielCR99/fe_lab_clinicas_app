import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../widgets/lab_clinicas_self_service_app_bar.dart';

final class DocumentsScanPage extends StatefulWidget {
  const DocumentsScanPage({super.key});

  @override
  State<DocumentsScanPage> createState() => _DocumentsScanPageState();
}

final class _DocumentsScanPageState extends State<DocumentsScanPage> {
  late final CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      Injector.get<List<CameraDescription>>().first,
      ResolutionPreset.ultraHigh,
    );
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
            child: Column(
              children: [
                Image.asset('assets/images/cam_icon.png'),
                const SizedBox(height: 15),
                const Text('TIRE A FOTO AGORA', style: titleSmallStyle),
                const SizedBox(height: 15),
                const Text(
                  'Posicione o documento dentro do quadrado abaixo e aperte o '
                  'botão para tirar a foto',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FutureBuilder(
                  future: _cameraController.initialize(),
                  builder: (context, snapshot) => switch (snapshot) {
                    AsyncSnapshot(
                      connectionState: ConnectionState.waiting ||
                          ConnectionState.active,
                    ) =>
                      const CircularProgressIndicator.adaptive(),
                    AsyncSnapshot(connectionState: ConnectionState.done)
                        when _cameraController.value.isInitialized =>
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        child: SizedBox(
                          width: sizeOf.width * 0.45,
                          child: CameraPreview(
                            _cameraController,
                            child: const DottedBorder(
                              options: RoundedRectDottedBorderOptions(
                                color: orangeColor,
                                strokeWidth: 4,
                                dashPattern: [1, 10, 1, 3],
                                radius: Radius.circular(16),
                                strokeCap: StrokeCap.square,
                              ),
                              child: SizedBox.expand(),
                            ),
                          ),
                        ),
                      ),
                    _ => const Center(
                      child: Text(
                        'Erro ao inicializar a câmera',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: sizeOf.width * 0.8,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _onPressedTakePhoto,
                    child: const Text('TIRAR FOTO'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressedTakePhoto() async {
    final navigator = Navigator.of(context);

    final photo = await _cameraController.takePicture().asyncLoader();

    navigator.pushNamed<void>(
      '/self-service/documents/scan/confirm',
      arguments: photo,
    );
  }
}
