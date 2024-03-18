import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../../services/user_login_service.dart';
import '../../../services/user_login_service_impl.dart';
import 'login_controller.dart';
import 'login_page.dart';

final class LoginRouter extends FlutterGetItModulePageRouter {
  const LoginRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<UserLoginService>(
          (i) => UserLoginServiceImpl(userRepository: i()),
        ),
        Bind.lazySingleton((i) => LoginController(userLoginService: i())),
      ];

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}
