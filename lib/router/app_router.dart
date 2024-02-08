import 'package:auto_route/auto_route.dart';

import '../presentation/pages/home/home.dart';
import '../presentation/pages/login/login.dart';
import '../presentation/pages/on_board/on_board.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnBoardRoute.page, path: "/"),
        AutoRoute(page: LoginRoute.page, path: "/login"),
        AutoRoute(page: HomeRoute.page, path: "/home")
      ];
}
