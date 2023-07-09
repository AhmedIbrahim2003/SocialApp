import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/services.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';

import 'modules/home/screens/chat_details.dart';

SnackBar errorSnakeBar(String? errorMessage) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'On Snap!',
      message: errorMessage!,
      contentType: ContentType.failure,
    ),
  );
}

SnackBar successSnakeBar() {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Email sent!',
      message: 'Please Check your email',
      contentType: ContentType.success,
    ),
  );
}

Container verfiyMessage(context) {
  return Container(
    height: 50,
    width: double.infinity,
    color: Colors.amber.withOpacity(0.6),
    child: Row(
      children: [
        const Icon(Icons.error_outline),
        const Expanded(
          child: Text('   Please verfiy your account'),
        ),
        TextButton(
          onPressed: () {
            SocialAppCubit.get(context).sendVerficationEmail();
          },
          child: const Text(
            'verfiy now',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ],
    ),
  );
}

Padding feedLayout({
  context,
  index,
  @required String? pfpURL,
  @required String? userName,
  @required String? imageURL,
  @required String? dateTime,
  @required String? postCaption,
  @required String? likes,
  @required String? commentsCount,
}) {
  TextEditingController commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Colors.grey,
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: NetworkImage(pfpURL!),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    dateTime!,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            postCaption!,
            style: const TextStyle(fontSize: 18),
          ),
          Column(
            children: [
              if (SocialAppCubit.get(context).posts[index].postImage != '')
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(
                      imageURL!,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(likes!),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(commentsCount!),
                    ],
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          SocialAppCubit.get(context).likePost(
                              SocialAppCubit.get(context).postsIds[index]);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.redAccent,
                        ),
                      ),
                      const Text('Like')
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.comment_outlined,
                        ),
                      ),
                      const Text('Comments')
                    ],
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage(pfpURL),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'comment Can\'t Be Empty';
                          } else {
                            return null;
                          }
                        },
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Write your comment here...',
                          enabledBorder: InputBorder.none,
                          suffixIcon: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialAppCubit.get(context).commentPost(
                                    SocialAppCubit.get(context).postsIds[index],
                                    commentController.text);
                              }
                            },
                            child: const Text('Comment'),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.grey,
                height: 2,
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget usersLayout({
  String? userImageUrl,
  String? userName,
  context,
  UserData? userData
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ChatDetails(userData: userData,),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(
                image: NetworkImage(userImageUrl!),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
