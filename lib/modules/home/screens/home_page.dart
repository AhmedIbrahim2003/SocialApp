import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';
import 'package:social_app/modules/home/cubit/states.dart';
import 'package:social_app/modules/home/screens/post_screen.dart';

import '../../../widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    SocialAppCubit.get(context).getUserData();
    SocialAppCubit.get(context).getPosts();
    SocialAppCubit.get(context).getAllUsers();
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is SendEmailSuccessState) {
          var snakeBar = successSnakeBar();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snakeBar);
        }

        if(state is PostPageSelectedState){
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const PostScreen(),
              ),
            );
        }
      },
      builder: (context, state) {
        var userData = SocialAppCubit.get(context).userData;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Facebox'),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search))
            ],
          ),
          body: ConditionalBuilder(
            condition: userData != null,
            builder: (context) {
              return SocialAppCubit.get(context).screens[SocialAppCubit.get(context).currentPageIndex];
            },
            fallback: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: SocialAppCubit.get(context).currentPageIndex,
              onTap: (value) =>
                  SocialAppCubit.get(context).bottomNavBarChange(value),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper_outlined), label: 'Feed'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mail_outlined), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_box_outlined), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people_outline), label: 'Users'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
