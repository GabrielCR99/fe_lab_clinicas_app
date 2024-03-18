import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../../../repositories/documents/documents_repository.dart';
import '../../../../repositories/documents/documents_repository_impl.dart';
import 'documents_scan_confirm_controller.dart';
import 'documents_scan_confirm_page.dart';

final class DocumentsScanConfirmRouter extends FlutterGetItModulePageRouter {
  const DocumentsScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<DocumentsRepository>(
          (i) => DocumentsRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton(
          (i) => DocumentsScanConfirmController(documentsRepository: i()),
        ),
      ];
  @override
  WidgetBuilder get view => (_) => const DocumentsScanConfirmPage();
}
