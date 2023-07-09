import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget.dart';
import '../../home/screens/home_page.dart';
import '../../login/screens/login_screen.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {
          if (state is CreatUserSuccessState) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is RegisterErrorState) {
            var snakeBar = errorSnakeBar(state.error);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snakeBar);
          }
        },
        builder: (BuildContext context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 100),
                            TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Your Name';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                label: Text('Name'),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                  return 'Please Enter Your Phone';
                                } else {
                                  return null;
                                }
                              },
                              controller: phoneController,
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                label: Text('Phone'),
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
                                    RegisterCubit.get(context)
                                        .registerChangePasswordIcon();
                                  },
                                  icon: Icon(RegisterCubit.get(context)
                                      .showPasswordIcon),
                                ),
                              ),
                              obscureText:
                                  RegisterCubit.get(context).showpassword,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty ||
                                    value != passwordController.text) {
                                  return 'Please Enter The Same Password';
                                } else {
                                  return null;
                                }
                              },
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(),
                                label: const Text('Confirm Password'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    RegisterCubit.get(context)
                                        .registerChangePasswordIcon();
                                  },
                                  icon: Icon(RegisterCubit.get(context)
                                      .showPasswordIcon),
                                ),
                              ),
                              obscureText:
                                  RegisterCubit.get(context).showpassword,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ));
                                },
                                child: const Text('Already has an account?')),
                            const SizedBox(height: 10),
                            //state is! ShopLoadingUpdateDataState ?
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).registerUser(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
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
                                    'REGISTER',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
