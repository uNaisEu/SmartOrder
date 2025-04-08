import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../providers/navigation_provider.dart';
import '../../../utils/route_utils.dart';
import '../../../constants/constants_text.dart';


class NotFoundPage extends StatelessWidget {
  const NotFoundPage({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(ConstantsText.notFoundPageText),
            TextButton(
              onPressed: () {
                GetIt.I<NavigationProvider>().navigateTo(Pages.menu.pageName);
              }, 
              child: const Text(ConstantsText.backToMenuPageText)
            )
          ],
        ),
      ),
    );
  }
}