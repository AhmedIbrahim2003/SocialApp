import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/home/cubit/states.dart';

import '../cubit/cubit.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? coverImage;
  var coverPicker = ImagePicker();

  Future getCoverImage() async {
    final pickedFile = await coverPicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        coverImage = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  File? profileImage;
  var profilePicker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await profilePicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController bioController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    bioController.text = SocialAppCubit.get(context).userData!.bio!;
    nameController.text = SocialAppCubit.get(context).userData!.name!;
    phoneController.text = SocialAppCubit.get(context).userData!.phone!;
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Your Profile'),
            actions: [
              TextButton(
                onPressed: () {
                  formKey.currentState!.validate();
                  SocialAppCubit.get(context).changeUserData(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialUpdateUserDataLoadingState)
                  const LinearProgressIndicator(),
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Image(
                              image: coverImage == null
                                  ? NetworkImage(
                                      SocialAppCubit.get(context)
                                          .userData!
                                          .cover!,
                                    )
                                  : FileImage(coverImage!) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          FloatingActionButton(
                            heroTag: 'edit cover',
                            mini: true,
                            onPressed: () {
                              //! todo: add edit profile cover function
                              getCoverImage();
                            },
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image(
                                  image: profileImage == null
                                      ? NetworkImage(
                                          SocialAppCubit.get(context)
                                              .userData!
                                              .image!,
                                        )
                                      : FileImage(profileImage!)
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            FloatingActionButton(
                              heroTag: 'edit pfp',
                              mini: true,
                              onPressed: () async {
                                //! todo: add edit profile picture function
                                getProfileImage();
                              },
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (profileImage != null || coverImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    SocialAppCubit.get(context)
                                        .uploadProfileImage(
                                      profileImage: profileImage,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange),
                                    child: const Text(
                                      'Upload Profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                if (state
                                    is SocialUploadProfileImageLoadingState)
                                  const LinearProgressIndicator()
                              ],
                            ),
                          ),
                        const SizedBox(width: 5),
                        if (coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    SocialAppCubit.get(context)
                                        .uploadCoverImage(
                                      coverImage: coverImage,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange),
                                    child: const Text(
                                      'Upload Cover',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                if (state is SocialUploadCoverImageLoadingState)
                                  const LinearProgressIndicator()
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            label: Text('Change Your Name'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name Can\'t Be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: bioController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            label: Text('Change Your Bio'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(),
                            label: Text('Change Your Name'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Can\'t Be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
