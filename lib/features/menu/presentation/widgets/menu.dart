import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/router/app_router.dart';
import 'category_navigation_bar.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../providers/menu_provider.dart';
import '../../providers/menu_state.dart';
import 'category_item.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final ScrollController _scrollController = ScrollController();
  int _observedIndex = 0;

  void _scrollToIndex(int index) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        280.0 * index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      ).then((_) {
        setState(() {
          _observedIndex = index;
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MenuState>(
      stream: GetIt.I<MenuProvider>().state,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is MenuLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MenuLoadingFailed) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showAnotherSnackBar(AppRouter.rootContext!, state.failure.message);
          });
        } else if (state is MenuLoaded) {
          final menu = state.menuList;
          final categories = menu.map((menuEntity) => menuEntity.category).toSet().toList();

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  surfaceTintColor: Colors.transparent,
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CategoryNavigationBar(
                        categories: categories,
                        selectedIndex: _observedIndex,
                        onPressed: (index) => _scrollToIndex(index),
                      ),
                      const Divider(height: 0),
                    ],
                  ),
                ),
              ];
            },
            body: CustomScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final category = menu[index];
                      return CategoryItem(
                        menu: category,
                        observedIndex: _observedIndex,
                        index: index,
                      );
                    },
                    childCount: menu.length,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
