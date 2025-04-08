import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';

import '../../../../features/login/providers/login_provider.dart';
import '../../../../features/login/providers/login_state.dart';
import '../../../providers/navigation_provider.dart';
import '../../../utils/route_utils.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<LoginState>(
        stream: GetIt.I<LoginProvider>().state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state != null && state is !LoginLoading) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              GetIt.I<NavigationProvider>()
                .navigateTo(Pages.menu.pagePath);
            });
          }
          
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      ),
    );
  }
}