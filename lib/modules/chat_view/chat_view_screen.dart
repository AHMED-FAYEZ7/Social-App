import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatViewScreen extends StatelessWidget {

  UserModel? userModel;

  ChatViewScreen({
    this.userModel,
});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      '${userModel!.image}'
                  ),
                ),
                SizedBox(width: 15,),
                Text(
                    '${userModel!.name}'
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                buildMess(),
                buildMyMess(),
                const SizedBox(height: 10,),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          controller: textController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            hintText: 'Message',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: ()
                      {
                        AppCubit.get(context).sendMessage(
                            receiverId: '${userModel!.uId}',
                            text: textController.text,
                            dateTime: '${DateTime.now()}',
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: defaultColor,
                        radius:25,
                        child: Icon(
                          IconBroken.Send,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMess() => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
        'Hi my friend',
      ),
    ),
  );

  Widget buildMyMess() => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: defaultColor.withOpacity(.5),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      child: Text(
        'Hi my friend',
      ),
    ),
  );
}
