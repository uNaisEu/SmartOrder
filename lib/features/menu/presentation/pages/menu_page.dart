import 'package:flutter/material.dart';

import '../widgets/menu.dart';


class MenuPage extends StatelessWidget {
  const MenuPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Menu()
      )
    );
  }
}