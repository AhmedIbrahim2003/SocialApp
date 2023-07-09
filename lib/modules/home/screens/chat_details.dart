// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/chat_model.dart';

import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';
import 'package:social_app/modules/home/cubit/states.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({
    Key? key,
    this.userData,
  }) : super(key: key);
  final UserData? userData;

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(builder: (context) {
      SocialAppCubit.get(context).getMessages(reciverId: userData!.uId);

      return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage(
                          userData!.image!,
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('ana 7azen')
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialAppCubit.get(context).messages.isNotEmpty,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 50,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (SocialAppCubit.get(context)
                                      .messages[index]
                                      .senderId ==
                                  SocialAppCubit.get(context).userData!.uId) {
                                return buildSentMessage(
                                    messageModel: SocialAppCubit.get(context)
                                        .messages[index]);
                              } else {
                                return buildRecievedMessage(
                                    messageModel: SocialAppCubit.get(context)
                                        .messages[index]);
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                            itemCount:
                                SocialAppCubit.get(context).messages.length),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    hintText: '   Type a message',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        SocialAppCubit.get(context).sendMessage(
                                            reciverId: userData!.uId,
                                            dateTime: DateTime.now().toString(),
                                            text: messageController.text);
                                            messageController.text = '';
                                      },
                                      icon: const Icon(Icons.send),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              fallback: (context) {
                return Column(
                  children: [
                    const Expanded(
                        child: Center(child: Text('No messages yet...'))),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  hintText: '   Type a message',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      SocialAppCubit.get(context).sendMessage(
                                          reciverId: userData!.uId,
                                          dateTime: DateTime.now().toString(),
                                          text: messageController.text);
                                          messageController.text = '';
                                    },
                                    icon: const Icon(Icons.send),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      );
    });
  }

  Align buildSentMessage({MessageModel? messageModel}) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            bottomStart: Radius.circular(10),
          ),
        ),
        child: Text(
          messageModel!.text!,
          style: const TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Align buildRecievedMessage({MessageModel? messageModel}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          ),
        ),
        child: Text(
          messageModel!.text!,
          style: const TextStyle(fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
