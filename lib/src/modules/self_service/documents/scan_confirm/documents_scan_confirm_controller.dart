import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../repositories/documents/documents_repository.dart';

final class DocumentsScanConfirmController with MessagesControllerMixin {
  final pathRemoteStorage = signal<String?>(null, autoDispose: true);

  final DocumentsRepository _documentsRepository;

  DocumentsScanConfirmController({
    required DocumentsRepository documentsRepository,
  }) : _documentsRepository = documentsRepository;

  Future<void> uploadImage({
    required Uint8List imageBytes,
    required String fileName,
  }) async {
    final result = await _documentsRepository
        .uploadImage(file: imageBytes, imageName: fileName)
        .asyncLoader();

    return switch (result) {
      Left() => showError('Erro ao fazer upload da imagem'),
      Right(:final value) => pathRemoteStorage.value = value,
    };
  }
}
