import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import 'login/login_router.dart';

final class AuthModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton<UserRepository>(
      (i) => UserRepositoryImpl(restClient: i()),
    ),
  ];
  @override
  String get moduleRouteName => '/auth';

  @override
  Map<String, WidgetBuilder> get pages => {
    '/login': (_) => const LoginRouter(),
  };
}
