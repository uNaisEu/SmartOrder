import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_it/get_it.dart';

import '../../../../features/login/providers/login_provider.dart';
import '../../../../features/login/providers/login_state.dart';
import '../../../constants/constants_text.dart';
import '../../../providers/navigation_provider.dart';
import '../../../utils/snackbar_utils.dart';
import '../../../router/app_router.dart';
import 'settings_modal_sheet.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  void openUserSetting(BuildContext context, LoginState? state) {
    if (state is LoginAuthenticated) {
      showModalBottomSheet(
        context: AppRouter.rootContext!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
        ),
        builder: (context) => SettingsModalSheet(user: state.user)
      );
    } else {
      showAnotherSnackBar(AppRouter.rootContext!, ConstantsText.authRequiredMessage);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 80,
      centerTitle: true,
      title: StreamBuilder<LoginState>(
        stream: GetIt.I<LoginProvider>().state,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => openUserSetting(context, snapshot.data),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ГБОУ ВО НГИЭУ",
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface)
                ),
                Text(
                  "В столовой",
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)
                ),
              ],
            ),
          );
        }
      ),
      actions: [
        StreamBuilder<LoginState>(
          stream: GetIt.I<LoginProvider>().state,
          builder: (context, snapshot) {
            if (snapshot.data is LoginAuthenticated) {
              LoginAuthenticated state = snapshot.data as LoginAuthenticated;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => openUserSetting(context, state),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.2),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            state.user.image,
                          ),
                        )
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton(
                  onPressed: () => GetIt.I<NavigationProvider>().navigateTo('/login', isPushed: true),
                  child: Text(
                    "Войти",
                    style: Theme.of(context).textTheme.titleMedium!
                        .copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary
                        ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}