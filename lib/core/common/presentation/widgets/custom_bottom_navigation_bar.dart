import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../features/basket/providers/basket_provider.dart';
import '../../../providers/navigation_provider.dart';
import '../../../utils/route_utils.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({ 
    super.key,
  });

  @override
  Widget build(BuildContext context){    
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 0.3,
          ),
        ),
      ),
      child: Consumer2<NavigationProvider, BasketProvider>(
        builder: (context, navigationProvider, basketProvider, child) {
          Map<Pages, NavigationDestination> destinationMap = {
            Pages.menu: const NavigationDestination(
              icon: Icon(Icons.food_bank), 
              label: "Меню"
            ),
            Pages.basket: NavigationDestination(
              icon: basketProvider.itemCount > 0 
                  ? Badge.count(
                      count: basketProvider.itemCount,
                      child: const Icon(Icons.shopping_bag_rounded),
                    )
                  : const Icon(Icons.shopping_bag_rounded),
              label: "Корзина"
            ) 
          };
          MapEntry<double, NavigationDestinationLabelBehavior> navigationTitlesParams =
              const MapEntry(48.0, NavigationDestinationLabelBehavior.alwaysHide);
          
          int selectedIndex = 
              destinationMap.keys.toList().indexOf(navigationProvider.selectedPage);          
          if (selectedIndex == -1) {
            return const SizedBox();
          }

          return NavigationBar(
            height: navigationTitlesParams.key,
            onDestinationSelected: (int index) {
              GetIt.I<NavigationProvider>()
                     .navigateTo(destinationMap.keys.toList()[index].pagePath);
            },
            backgroundColor: Theme.of(context).colorScheme.surface,
            indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
            selectedIndex: selectedIndex,
            labelBehavior: navigationTitlesParams.value,
            destinations: destinationMap.values.toList(),
          );
        }
      )
    );
  }
}