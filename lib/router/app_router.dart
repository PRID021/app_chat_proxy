import 'package:auto_route/auto_route.dart';

import '../application/pages/home/home.dart';
import '../application/pages/login/login.dart';
import '../application/pages/on_board/on_board.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnBoardRoute.page, path: "/"),
        AutoRoute(page: LoginRoute.page, path: "/login"),
        AutoRoute(page: HomeRoute.page,path: "/home")
      ];
}
