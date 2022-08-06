

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/componants/constants.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates>
{
  AppCubit() :super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData()
  {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          userModel = UserModel.fromJson(value.data());
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
    const NewPostScreen(),
    const UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'POSTS',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index == 2 )
    {
      emit(AppAddPostState());
    } else
    {
      currentIndex = index;
      emit(AppChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(AppProfileImageErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AppCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(AppCoverImageErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(AppUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value)
          {
            // emit(AppUploadProfileImageSuccessState());
            updateUserData(
              name: name,
              phone: phone,
              bio: bio,
              image: value,
            );
          }).catchError((error) {
            emit(AppUploadProfileImageErrorState());
          });
    }).catchError((error) {
      emit(AppUploadProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
})
  {
    emit(AppUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        emit(AppUploadCoverImageSuccessState());
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(AppUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(AppUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // })
  // {
  //   emit(AppUserUpdateLoadingState());
  //   if(coverImage != null )
  //   {
  //     uploadCoverImage();
  //   }else if(profileImage != null)
  //   {
  //     uploadProfileImage();
  //   } else if(coverImage != null && profileImage !=null )
  //   {
  //
  //   } else
  //   {
  //     updateUserData(name: name, phone: phone, bio: bio,);
  //   }
  // }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
})
  {
    UserModel model = UserModel(
      uId: userModel!.uId,
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      image: image??userModel!.image,
      cover: cover??userModel!.cover,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance.collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error) {
      emit(AppUserUpdateErrorState());
    });
  }
}