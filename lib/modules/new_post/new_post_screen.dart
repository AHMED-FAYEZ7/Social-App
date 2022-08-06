import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../shared/componants/componants.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();
  var dateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        var postImage = AppCubit.get(context).postImage;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                text: 'Post',
                function: ()
                {
                  var dateTimeNow = DateTime.now();
                  if(AppCubit.get(context).postImage == null)
                  {
                    AppCubit.get(context).createPost(
                        dateTime: dateTimeNow.toString(),
                        text: textController.text,
                    );
                  }else
                  {
                    AppCubit.get(context).createPostImage(
                      dateTime: dateTimeNow.toString(),
                      text: textController.text,
                    );
                  }
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is AppCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is AppCreatePostLoadingState)
                  SizedBox(height: 5,),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                          'https://images5.alphacoders.com/532/532559.jpg'
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Row(
                            children: const [
                              Text(
                                'Ahmed Fayez',
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(width: 5,),
                              Icon(
                                Icons.check_circle,
                                color: defaultColor,
                                size: 15,
                              ),
                            ],
                          ),
                          Text(
                            'public',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,

                    ),
                  ),
                ),
                if(AppCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: FileImage(postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: ()
                        {
                          AppCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          radius: 22,
                          child: Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          AppCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              IconBroken.Image
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child:const Text(
                              '# tags',
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
}
