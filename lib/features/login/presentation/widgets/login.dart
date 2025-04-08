import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/providers/navigation_provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../domain/entities/login_entity.dart';
import '../../providers/login_provider.dart';
import '../../providers/login_state.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final loginProvider = GetIt.I<LoginProvider>();
      final loginEntity = LoginEntity(
        username: _loginController.text,
        password: _passwordController.text,
      );
      loginProvider.login(loginEntity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: StreamBuilder<LoginState>(
        stream: GetIt.I<LoginProvider>().state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state is LoginAuthenticated) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              GetIt.I<NavigationProvider>()
                .navigateTo(Pages.menu.pagePath);
            });
          } else if (state is LoginFailure) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showAnotherSnackBar(AppRouter.rootContext!, state.failure.message);
            });
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Добро пожаловать",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Введите логин и пароль для входа",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        labelText: "Логин",
                        labelStyle: theme.textTheme.bodyLarge,
                        prefixIcon: Icon(Icons.person, color: theme.colorScheme.primary),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите логин';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Пароль",
                        labelStyle: theme.textTheme.bodyLarge,
                        prefixIcon: Icon(Icons.lock, color: theme.colorScheme.primary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите пароль';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primaryContainer,
                          foregroundColor: theme.colorScheme.onPrimaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: (state is LoginLoading) ? null : () => _login(context),
                        child: (state is LoginLoading)
                            ? CircularProgressIndicator(color: theme.colorScheme.onPrimary)
                            : Text(
                                "Войти",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
