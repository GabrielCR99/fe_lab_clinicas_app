import 'dart:typed_data';

import 'package:lab_clinicas_core/lab_clinicas_core.dart';

abstract interface class DocumentsRepository {
  Future<Either<RepositoryException, String>> uploadImage({
    required Uint8List file,
    required String imageName,
  });
}
