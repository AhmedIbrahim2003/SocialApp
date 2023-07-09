import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';

import '../cubit/states.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SocialAppCubit.get(context);
    var userData = cubit.userData;
    TextEditingController postController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (cubit.postImage == null) {
                        cubit.createPost(
                          dateTime: DateTime.now().toString(),
                          text: postController.text,
                        );
                      } else {
                        cubit.uploadPostImage(
                          dateTime: DateTime.now().toString(),
                          text: postController.text,
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
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
                          image: NetworkImage(userData!.image!),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      userData.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'post Can\'t Be Empty';
                        } else {
                          return null;
                        }
                      },
                      controller: postController,
                      decoration: const InputDecoration(
                          hintText: 'What is on your mind...',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Image(
                          image: FileImage(cubit.postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getpostImage();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_outlined),
                            SizedBox(width: 5),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('# tags'),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
