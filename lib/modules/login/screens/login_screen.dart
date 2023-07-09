import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/local/cache.dart';
import 'package:social_app/modules/register/screens/register_screen.dart';
import 'package:social_app/widget.dart';

import '../../home/screens/home_page.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.putData(key: 'uId', value: state.uId).then((value) {
            print(CacheHelper.getData(key: 'uId'));
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          });
        } else if (state is LoginErrorState) {
          var snakeBar = errorSnakeBar(state.error);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snakeBar);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 50),
                    ),
                    const SizedBox(height: 60),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password';
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(),
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                          onPressed: () {
                            LoginCubit.get(context).loginChangePasswordIcon();
                          },
                          icon: Icon(LoginCubit.get(context).showPasswordIcon),
                        ),
                      ),
                      obscureText: LoginCubit.get(context).showpassword,
                    ),
                    const SizedBox(height: 120),
                    InkWell(
                      onTap: () {
                        // TODO: add onTap function
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrange,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ));
                        },
                        child: const Text('Don\'t have an account?')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
