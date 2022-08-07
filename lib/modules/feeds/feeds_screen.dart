import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        return ConditionalBuilder(
          condition: AppCubit.get(context).posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  elevation: 5,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://c4.wallpaperflare.com/wallpaper/817/296/977/anime-4k-pc-hd-download-wallpaper-preview.jpg',
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildFeedItem(AppCubit.get(context).posts[index],context , index),
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                  itemCount: AppCubit.get(context).posts.length,
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFeedItem(PostModel model ,context, index) => Card(
    elevation: 5,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
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
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15,),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.more_horiz_outlined,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(
              '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 5,
          //     bottom: 10,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Container(
          //           padding: EdgeInsetsDirectional.only(
          //             end: 8,
          //           ),
          //           height: 25,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 1,
          //             padding: EdgeInsets.zero,
          //             child: Text(
          //               '#software',
          //               style: Theme.of(context).textTheme.caption!.copyWith(
          //                 color: defaultColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           padding: EdgeInsetsDirectional.only(
          //             end: 8,
          //           ),
          //           height: 25,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 1,
          //             padding: EdgeInsets.zero,
          //             child: Text(
          //               '#flutter-dev',
          //               style: Theme.of(context).textTheme.caption!.copyWith(
          //                 color: defaultColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsetsDirectional.only(top: 15),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(
                      '${model.postImage}'
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            size: 18,
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            '${AppCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            size: 18,
                            IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).userModel!.image}',
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      size: 18,
                      IconBroken.Heart,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
                  AppCubit.get(context).postLikes(AppCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
