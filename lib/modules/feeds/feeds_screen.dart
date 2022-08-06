import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
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
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildFeedItem(context),
              separatorBuilder: (context, index) => SizedBox(height: 5,),
              itemCount: 10,
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget buildFeedItem(context) => Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children:
        [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
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
                      children: [
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
                      'March 1,2022 at 05:00 pm',
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
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 10,
            ),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      end: 8,
                    ),
                    height: 25,
                    child: MaterialButton(
                      onPressed: (){},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#software',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      end: 8,
                    ),
                    height: 25,
                    child: MaterialButton(
                      onPressed: (){},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#flutter-dev',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          color: defaultColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: NetworkImage(
                  'https://c4.wallpaperflare.com/wallpaper/817/296/977/anime-4k-pc-hd-download-wallpaper-preview.jpg',
                ),
                fit: BoxFit.cover,
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
                          SizedBox(width: 5,),
                          Text(
                            '1400',
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
                            '140 comment',
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
                            'https://images5.alphacoders.com/532/532559.jpg'
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
                onTap: (){},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
