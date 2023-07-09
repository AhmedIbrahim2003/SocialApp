// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/app_theme.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';
import 'package:social_app/modules/home/screens/home_page.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';

import 'constants.dart';
import 'local/cache.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/screens/login_screen.dart';
import 'my_bloc_opserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');
  Widget? startScreen = uId == null ? const LoginScreen() : const HomePage();

  runApp(MainApp(
    startScreen: startScreen,
  ));
}

class MainApp extends StatelessWidget {
  final Widget startScreen;
  const MainApp({
    Key? key,
    required this.startScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => SocialAppCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startScreen,
      ),
    );
  }
}
