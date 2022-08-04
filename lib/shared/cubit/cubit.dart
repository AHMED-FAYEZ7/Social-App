import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/componants/constants.dart';
import 'package:social_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() :super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  void getUserData()
  {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          model = UserModel.fromJson(value.data());
          emit(AppGetUserSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(AppGetUserErrorState(error.toString()));
    });

  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }


}