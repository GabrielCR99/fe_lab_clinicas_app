import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/self_service_model.dart';

abstract interface class InformationFormRepository {
  Future<Either<RepositoryException, Unit>> register(SelfServiceModel model);
}
