
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/componants/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/theme.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on back message');
  print(message.data.toString());

  showToast(text: 'on back message', state: ToastStates.SUCCESS,);
}

void main()
{
  BlocOverrides.runZoned(() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    var token = await FirebaseMessaging.instance.getToken();
    print(token);

    FirebaseMessaging.onMessage.listen((event)
    {
      print('on message');
      print(event.data.toString());

      showToast(text: 'on message', state: ToastStates.SUCCESS,);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event)
    {
      print('on message opened app');
      print(event.data.toString());

      showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


    await CacheHelper.init();
    Widget? widget;


    if(uId != null)
      {
        widget = SocialLayout();
      }else
      {
        widget = LoginScreen();
      }
    runApp(MyApp(widget));
  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{

  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getUserData()
        ..getPosts()
        ..getAllUsers(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}