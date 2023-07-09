import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home/cubit/cubit.dart';
import 'package:social_app/modules/home/cubit/states.dart';
import 'package:social_app/modules/home/screens/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Image(
                      image:
                          NetworkImage(SocialAppCubit.get(context).userData!.cover!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: NetworkImage(
                            SocialAppCubit.get(context).userData!.image!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              SocialAppCubit.get(context).userData!.name!,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              SocialAppCubit.get(context).userData!.bio!,
              style: const TextStyle(
                fontSize: 15,
              ),
              softWrap: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                userActivityCounters(number: '100', name: 'Posts'),
                userActivityCounters(number: '269', name: 'Photos'),
                userActivityCounters(number: '10k', name: 'Followers'),
                userActivityCounters(number: '64', name: 'Followings'),
              ],
            ),
            const SizedBox(height: 15),
            
Row(
  children: [
    Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          height: 40,
          child: const Text(
            'Add Photos',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
      ),
    ),
    const SizedBox(width: 5),
    InkWell(
      onTap: (){
        Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => EditProfile(),
              ),
            );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        height: 40,
        width: 50,
        child: const Icon(Icons.edit, color: Colors.deepOrange),
      ),
    )
  ],
)

          ],
        );
      },
    );
  }

  Column userActivityCounters({required String number, required String name}) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }
}
