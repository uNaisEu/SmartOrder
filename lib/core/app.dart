import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../features/basket/providers/basket_provider.dart';
import 'constants/constants_text.dart';
import 'providers/navigation_provider.dart';
import 'router/app_router.dart';
import 'utils/theme_utils.dart';


class App extends StatelessWidget {
  const App({ super.key });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetIt.I<NavigationProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<BasketProvider>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
        title: ConstantsText.appName,
        theme: createTheme(
          context, 
          const Color.fromARGB(255, 61, 127, 207), 
          Brightness.light
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: child ?? const SizedBox(),
          );
        }
      ),
    );
  }
}