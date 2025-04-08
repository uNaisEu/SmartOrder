import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/basket/presentation/pages/basket_page.dart';
import '../../features/login/domain/entities/user_entity.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/menu/presentation/pages/menu_page.dart';
import '../../features/order_payment/presentation/pages/orders_page.dart';
import '../common/presentation/pages/not_found_page.dart';
import '../utils/route_utils.dart';
import '../common/presentation/widgets/navigation.dart';
import '../common/presentation/pages/onboarding_page.dart';


class AppRouter {
  static late GoRouter _router;
  static late GlobalKey<NavigatorState> _rootNavigatorKey;

  static GoRouter get router => _router;
  static BuildContext? get rootContext => _rootNavigatorKey.currentContext;

  static Future<void> initialize() async {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/onboarding', //Pages.menu.pagePath,
      routes: [
        GoRoute(
          name: "onboarding",
          path: "/onboarding",
          pageBuilder: (_, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const OnboardingPage(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity:
                      CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          name: "login",
          path: "/login",
          pageBuilder: (_, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const LoginPage(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity:
                      CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (_, __, navigationShell) => 
              Navigation(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: Pages.menu.pageName,
                  path: Pages.menu.pagePath,
                  pageBuilder: (_, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const MenuPage(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity:
                              CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ]
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: Pages.basket.pageName,
                  path: Pages.basket.pagePath,
                  pageBuilder: (_, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: const BasketPage(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity:
                              CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                ),
                GoRoute(
                  name: "orders",
                  path: "/orders",
                  pageBuilder: (_, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: OrdersPage(user: state.extra as UserEntity),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity:
                              CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ]
            ),
          ]
        )
      ],
      errorBuilder: (_, __) => const NotFoundPage(),
    );
  }
}