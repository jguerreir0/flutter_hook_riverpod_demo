import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks_demo/presentation/authenticated_page.dart';
import 'presentation/ui.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        AutoRoute(path: '/success', page: AuthenticatedRoute.page),
      ];
}
