import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../../models/self_service_model.dart';
import '../self_service_controller.dart';
import '../widgets/lab_clinicas_self_service_app_bar.dart';
import 'widgets/document_box.dart';

final class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

final class _DocumentsPageState extends State<DocumentsPage> {
  final _selfServiceController = Injector.get<SelfServiceController>();

  @override
  void initState() {
    super.initState();
    context.messageListener(_selfServiceController);
  }

  Future<void> _onTapDocumentBox(DocumentType documentType) async {
    final filePath = await Navigator.of(
      context,
    ).pushNamed<Object?>('/self-service/documents/scan');

    if (filePath != null && filePath != '') {
      _selfServiceController.registerDocument(documentType, filePath as String);

      if (mounted) {
        setState(() {
          return;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final documents = _selfServiceController.model.documents ?? const {};
    final totalHealthInsuranceCard =
        documents[DocumentType.healthInsuranceCard]?.length ?? 0;
    final totalMedicalOrder = documents[DocumentType.medicalOrder]?.length ?? 0;

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
                Image.asset('assets/images/folder.png'),
                const SizedBox(height: 24),
                const Text('ADICIONAR DOCUMENTOS', style: titleSmallStyle),
                const SizedBox(height: 32),
                const Text(
                  'Selecione o documento que deseja fotografar',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: sizeOf.width * 0.8,
                  height: 300,
                  child: Row(
                    children: [
                      DocumentBox(
                        hasUploaded: totalHealthInsuranceCard > 0,
                        icon: Image.asset('assets/images/id_card.png'),
                        label: 'CARTEIRINHA',
                        totalFiles: totalHealthInsuranceCard,
                        onTap: () =>
                            _onTapDocumentBox(DocumentType.healthInsuranceCard),
                      ),
                      const SizedBox(width: 32),
                      DocumentBox(
                        hasUploaded: totalMedicalOrder > 0,
                        icon: Image.asset('assets/images/document.png'),
                        label: 'PEDIDO MÉDICO',
                        totalFiles: totalMedicalOrder,
                        onTap: () =>
                            _onTapDocumentBox(DocumentType.medicalOrder),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (totalMedicalOrder > 0 && totalHealthInsuranceCard > 0)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _onPressedRemoveAll,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            fixedSize: const Size.fromHeight(48),
                          ),
                          child: const Text('REMOVER TODAS'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _selfServiceController.finishProcess,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orangeColor,
                            fixedSize: const Size.fromHeight(48),
                          ),
                          child: const Text('FINALIZAR'),
                        ),
                      ),
                    ],
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedRemoveAll() {
    _selfServiceController.clearDocuments();
    setState(() {
      return;
    });
  }
}
