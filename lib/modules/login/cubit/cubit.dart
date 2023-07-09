// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool showpassword = true;
  IconData showPasswordIcon = Icons.visibility;
  void loginChangePasswordIcon() {
    showpassword = !showpassword;
    showpassword
        ? showPasswordIcon = Icons.visibility
        : showPasswordIcon = Icons.visibility_off;
    emit(LoginPasswordState());
  }

  bool firstTime = false;
  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print('login done');
      firstTime = true;
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }
}
