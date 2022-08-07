import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../chat_view/chat_view_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        return ConditionalBuilder(
          condition: AppCubit.get(context).users!.isNotEmpty,
          builder: (context) =>ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context , index) => buildChatItem( AppCubit.get(context).users![index] , context),
            separatorBuilder: (context , index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            itemCount: AppCubit.get(context).users!.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model , context) => InkWell(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                '${model.image}'
            ),
          ),
          const SizedBox(width: 15,),
          Text(
            '${model.name}',
            style: TextStyle(
              fontSize: 18,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
    onTap: ()
    {
      navigateTo(context, ChatViewScreen(
        userModel: model,
      ));
    },
  );
}
