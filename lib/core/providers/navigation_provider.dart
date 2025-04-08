import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import '../utils/route_utils.dart';


class NavigationProvider extends ChangeNotifier {
  late GoRouter _router;
  late Pages _selectedPage;

  NavigationProvider() {
    _router = AppRouter.router;
    _selectedPage = 
        getPageByPath(_router.routerDelegate.currentConfiguration.fullPath);
  }

  GoRouter get router => _router;
  Pages get selectedPage => _selectedPage;

  void navigateTo(String path, {bool isPushed = false, Object? extra}) {
    if (!isPushed) {
      _router.go(path, extra: extra);
    } else {
      _router.push(path, extra: extra);
    }
    
    _selectedPage = 
          getPageByPath(_router.routerDelegate.currentConfiguration.fullPath);
    notifyListeners();
  }

  void goBack() {
    if (_router.canPop()) {
      _router.pop();
      _selectedPage = 
          getPageByPath(_router.routerDelegate.currentConfiguration.fullPath);
      notifyListeners();
    }
  }
}