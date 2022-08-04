
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/componants/constants.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/theme.dart';

void main()
{
  BlocOverrides.runZoned(() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await CacheHelper.init();
    Widget? widget;
    uId = CacheHelper.getData(key: 'uId');

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
      create: (BuildContext context) => AppCubit()..getUserData(),
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