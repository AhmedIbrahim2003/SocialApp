import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';
import 'package:social_app/modules/home/cubit/states.dart';

import '../../../widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          
          itemBuilder: (context, index) {
            return usersLayout();
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey,
              height: 2,
            );
          },
          itemCount: 10,
        );
      },
    );
  }
}
