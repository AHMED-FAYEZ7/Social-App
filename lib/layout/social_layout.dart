import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Posts',
            ),
          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).model != null,
            builder: (context)
            {
              return Column(
                children: [

                ],
              );
            },
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
