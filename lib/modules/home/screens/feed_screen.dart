import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';
import 'package:social_app/modules/home/cubit/states.dart';

import '../../../widget.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = SocialAppCubit.get(context);

    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.get(context).posts.isNotEmpty &&
              SocialAppCubit.get(context).userData != null,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context)
                  .size
                  .height, // or specify a fixed height
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return feedLayout(
                          context: context,
                          index: index,
                          pfpURL: cubit.posts[index].image,
                          userName: cubit.posts[index].name,
                          imageURL: cubit.posts[index].postImage,
                          dateTime: cubit.posts[index].dateTime,
                          postCaption: cubit.posts[index].text,
                          likes: cubit.likes[index].toString(),
                          commentsCount: cubit.commentsCount[index].toString(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                          height: 2,
                        );
                      },
                      itemCount: cubit.posts.length,
                      shrinkWrap:
                          true, // add this line to enable scrolling within the ListView
                      physics:
                          BouncingScrollPhysics(), // add this line to disable ListView scrolling
                    ),
                  ],
                ),
              ),
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
