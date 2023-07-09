// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/local/cache.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool showpassword = true;

  IconData showPasswordIcon = Icons.visibility;
  void registerChangePasswordIcon() {
    showpassword = !showpassword;
    showpassword
        ? showPasswordIcon = Icons.visibility
        : showPasswordIcon = Icons.visibility_off;
    emit(RegisterPasswordState());
  }

  bool firstTime = false;
  void registerUser(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      CacheHelper.putData(key: 'uId', value: value.user!.uid);
      firstTime = true;
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState(error: error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    String bio = 'Write Your Bio Here',
    bool isVerified = false,
    String image = 'https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg?w=826',
    String cover = 'https://i.pinimg.com/originals/5c/a8/5f/5ca85f284e5b794de57a01e72cf5dbe6.jpg',
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uId).set({
      'name': name,
      'email': email,
      'image': image,
      'cover': image,
      'phone': phone,
      'uId': uId,
      'isVerified': isVerified,
      'bio': bio,
    }).then((value) {
      print('User created succefully');
      emit(CreatUserSuccessState());
      emit(RegisterSuccessState());
    }).catchError((onError) {
      print('User creation failed');
      emit(CreatUserErrorState(error: onError.toString()));
    });
  }
}
