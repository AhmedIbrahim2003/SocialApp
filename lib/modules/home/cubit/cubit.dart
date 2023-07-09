// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unused_local_variable
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/chat_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/home/cubit/states.dart';
import 'package:social_app/modules/home/screens/chat_screen.dart';
import 'package:social_app/modules/home/screens/feed_screen.dart';
import 'package:social_app/modules/home/screens/users.dart';
import 'package:social_app/modules/home/screens/settings_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/post_model.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(HomeInitialState());
  static SocialAppCubit get(context) => BlocProvider.of(context);

  UserData? userData;

  void getUserData() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userData = UserData.fromJson(value.data());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  void sendVerficationEmail() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      print('email sent');
      emit(SendEmailSuccessState());
    }).catchError((error) {
      print(error);
      emit(SendEmailErrorState(error));
    });
  }

  int currentPageIndex = 0;
  int previousPageIndex = 0;
  List<Widget> screens = [
    const FeedScreen(),
    const ChatScreen(),
    Container(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  void bottomNavBarChange(int index) {
    previousPageIndex = currentPageIndex;
    currentPageIndex = index;
    if (currentPageIndex == 2) {
      emit(PostPageSelectedState());
      currentPageIndex = previousPageIndex;
    } else {
      emit(BottomNavBarChangeState());
    }
  }

  void uploadProfileImage({
    @required File? profileImage,
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        changeUserData(
          name: name,
          phone: phone,
          bio: bio,
          profileImageUrl: value,
        );
      }).catchError((onError) {
        print(onError);
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      print(onError);
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;
  void uploadCoverImage({
    @required File? coverImage,
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(SocialUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        changeUserData(
          name: name,
          phone: phone,
          bio: bio,
          coverImageUrl: value,
        );
      }).catchError((onError) {
        print(onError);
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((onError) {
      print(onError);
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void changeUserData({
    @required String? name,
    @required String? phone,
    @required String? bio,
    String? coverImageUrl,
    String? profileImageUrl,
  }) {
    emit(SocialUpdateUserDataLoadingState());
    UserData model = UserData(
      name: name,
      phone: phone,
      bio: bio,
      email: userData!.email,
      cover: coverImageUrl ?? userData!.cover,
      image: profileImageUrl ?? userData!.image,
      isVerified: userData!.isVerified,
      uId: userData!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uId)
        .update(model.toJson())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      print(onError);
      emit(SocialUpdateUserDataErrorState());
    });
  }

  File? postImage;
  var postPicker = ImagePicker();

  Future getpostImage() async {
    final pickedFile = await postPicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialUploadPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialUploadPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialremovePickedPostImageSuccessState());
  }

  void uploadPostImage({
    @required String? dateTime,
    @required String? text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((onError) {
        print(onError);
        emit(SocialCreatePostErrorState());
      });
    }).catchError((onError) {
      print(onError);
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    @required String? dateTime,
    @required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostData model = PostData(
        name: userData!.name,
        uId: userData!.uId,
        image: userData!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toJson())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostData> posts = [];
  List<String> postsIds = [];
  List<int> likes = [];
  List<int> comments = [];
  List<int> commentsCount = [];

  void getPosts() {
    posts = [];
    postsIds = [];
    likes = [];
    commentsCount = [];
    emit(GetPostDataLoadingState());
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime').get().then((value) {
      value.docs.forEach(
        (element) {
          element.reference.collection('like').get().then((value) {
            likes.add(value.docs.length);
            postsIds.add(element.id);
            posts.add(PostData.fromJson(element.data()));
            element.reference.collection('comments').get().then((value) {
              commentsCount.add(value.docs.length);
              print(commentsCount);
              emit(GetPostDataSuccessState());
            });
          });
        },
      );
    }).catchError((onError) {
      emit(GetPostDataErrorState(onError));
    });
  }

  void likePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('like')
        .doc(userData!.uId)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((onError) {
      emit(LikePostErrorState(onError));
    });
  }

  void commentPost(String? postId, String? commentText) {
    if (commentText != null && commentText != '') {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(userData!.uId)
          .set({'comment': commentText}).then((value) {
        emit(CommentPostSuccessState());
      }).catchError((onError) {
        emit(CommentPostErrorState(onError));
      });
    } else {
      print('empty comment');
    }
  }

  List<UserData> allUsers = [];

  void getAllUsers() {
    allUsers = [];
    emit(GetAllUserDataLoadingState());

    FirebaseFirestore.instance.collection('users').orderBy('name').get().then((value) {
      value.docs.forEach(
        (element) {
          if (userData!.uId != element.data()['uId']) {
            allUsers.add(UserData.fromJson(element.data()));
          }
        },
      );
    }).catchError((onError) {
      emit(GetPostDataErrorState(onError));
    });
  }

  void sendMessage({
    @required String? reciverId,
    @required String? dateTime,
    @required String? text,
  }) {
    if (text != null && text != '') {
      MessageModel model = MessageModel(
          senderId: userData!.uId,
          reciverId: reciverId,
          dateTime: dateTime,
          text: text);

      FirebaseFirestore.instance
          .collection('users')
          .doc(userData!.uId)
          .collection('chats')
          .doc(reciverId)
          .collection('messages')
          .add(model.toJson())
          .then((value) {
        emit(SendMessageSuccessState());
      }).catchError((onError) {
        emit(SendMessageErrorState(onError));
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(reciverId)
          .collection('chats')
          .doc(userData!.uId)
          .collection('messages')
          .add(model.toJson())
          .then((value) {
        emit(SendMessageSuccessState());
      }).catchError((onError) {
        emit(SendMessageErrorState(onError));
      });
    }
  }

  List<MessageModel> messages = [];

  void getMessages({
    @required String? reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen(
      (event) {
        messages = [];
        event.docs.forEach((element) {
          messages.add(MessageModel.fromJson(element.data()));
        });
        emit(ReciveMessageSuccessState());
      },
    );
  }
}
