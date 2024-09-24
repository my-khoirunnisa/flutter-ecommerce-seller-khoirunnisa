import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/pages/main_page.dart';

import '../../../core/core.dart';
import '../bloc/login/login_bloc.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(18.0),
          const Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: emailController,
            label: 'E-mail',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(12.0),

          const SpaceHeight(50.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (data) async {
                  await AuthLocalDatasource().saveAuthData(data);
                  // ignore: use_build_context_synchronously
                  context.pushReplacement(const MainPage());
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return Button.filled(
                  onPressed: () {
                    context.read<LoginBloc>().add(
                          LoginEvent.login(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  },
                  label: 'Login',
                  borderRadius: 99.0,
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
            },
          ),
          const SpaceHeight(12.0),
          // Button.filled(
          //   onPressed: () {
          //     context.pushReplacement(const MainPageSeller());
          //   },
          //   label: 'Login as Seller',
          //   borderRadius: 99.0,
          // ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {},
              child: const SizedBox(
                height: 50.0,
                child: Center(
                  child: Text('don\'t have an account yet? please register'),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.push(const RegisterPage());
              }, // context.push(const RegisterSellerPage()),
              child: const SizedBox(
                height: 50.0,
                child: Center(
                  child: Text('Daftarkan seller'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
