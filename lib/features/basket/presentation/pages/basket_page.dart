import 'package:flutter/material.dart';

import '../widgets/basket.dart';


class BasketPage extends StatelessWidget {
  const BasketPage({ super.key });

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: SafeArea(
        child: Basket()
      ),
    );
  }
}