import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'documents_repository.dart';

final class DocumentsRepositoryImpl implements DocumentsRepository {
  final RestClient restClient;

  const DocumentsRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, String>> uploadImage({
    required Uint8List file,
    required String imageName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: imageName),
      });
      final Response(data: {'url': String imagePath}!) = await restClient.auth
          .post<Map<String, dynamic>>('/uploads', data: formData);

      return Right(imagePath);
    } on DioException catch (e, s) {
      log('Erro ao fazer upload', error: e, stackTrace: s);

      return const Left(RepositoryException());
    }
  }
}
