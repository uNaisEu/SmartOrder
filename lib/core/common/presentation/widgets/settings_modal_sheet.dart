import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../features/login/domain/entities/user_entity.dart';
import '../../../../features/login/providers/login_provider.dart';
import '../../../providers/navigation_provider.dart';

class SettingsModalSheet extends StatelessWidget {
  const SettingsModalSheet({ 
    super.key,
    required this.user 
  });

  final UserEntity user; 

  @override
  Widget build(BuildContext context){
    return Ink(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            trailing: CircleAvatar(
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
                      user.image,
                    ),
                  )
                ),
              ),
            ),
            title: Text(
              user.name,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Выберите организацию"),
              value: 'ГБОУ ВО НГИЭУ',
              items: const [
                DropdownMenuItem(value: 'ГБОУ ВО НГИЭУ', child: Text('ГБОУ ВО НГИЭУ')),
              ],
              onChanged: (String? newValue) { },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('С собой'),
                    value: 'С собой',
                    groupValue: 'В столовой',
                    onChanged: (String? value) { },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('В столовой'),
                    value: 'В столовой',
                    groupValue: 'В столовой',
                    onChanged: (String? value) { },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(
              'Заказы и чеки',
              style: Theme.of(context).textTheme.labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            onTap: () {
              Navigator.pop(context);
              GetIt.I<NavigationProvider>().navigateTo('/orders', isPushed: true, extra: user);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(
              'Способы оплаты',
              style: Theme.of(context).textTheme.labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          ListTile(
            iconColor: Theme.of(context).colorScheme.error,
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              'Выйти из аккаунта',
              style: Theme.of(context).textTheme.labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () {
              GetIt.I<LoginProvider>().logout();
              Navigator.pop(context);
              GetIt.I<NavigationProvider>().goBack();
            },
          ),
        ],
      ),
    );
  }
}