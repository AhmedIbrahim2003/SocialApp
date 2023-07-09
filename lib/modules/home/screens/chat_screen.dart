import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.get(context).allUsers.isNotEmpty,
          builder: (context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return usersLayout(
                  userImageUrl:
                      SocialAppCubit.get(context).allUsers[index].image,
                  userName: SocialAppCubit.get(context).allUsers[index].name,
                  context: context,
                  userData: SocialAppCubit.get(context).allUsers[index]
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                  height: 2,
                );
              },
              itemCount: SocialAppCubit.get(context).allUsers.length,
            );
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
