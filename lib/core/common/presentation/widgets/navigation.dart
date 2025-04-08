import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/navigation_provider.dart';
import 'custom_app_bar.dart';
import 'custom_bottom_navigation_bar.dart';


class Navigation extends StatelessWidget {
  final Widget navigationShell;
  
  const Navigation({ 
    super.key, 
    required this.navigationShell, 
  });
  
  @override
  Widget build(BuildContext context){
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: const CustomAppBar(),
          body: navigationShell,
          bottomNavigationBar: const CustomBottomNavigationBar(),
        );
      }
    );
  }
}
