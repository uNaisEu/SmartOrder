import 'package:flutter/material.dart';

import '../widgets/login.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Login()
      )
    );
  }
}