import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
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
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
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
    if(index == 1)
    {
      getAllUsers();
    }
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

  File? postImage;

  Future<void> getPostImage() async
  {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(AppPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(AppPostImageErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(AppRemovePostImageState());
  }

  void createPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(AppCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value)
      {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(AppCreatePostErrorState());
      });
    }).catchError((error) {
      emit(AppCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    emit(AppCreatePostLoadingState());

    PostModel model = PostModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );

    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(AppCreatePostSuccessState());
    })
        .catchError((error) {
      emit(AppCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts()
  {
    emit(AppGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          for (var element in value.docs) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
              emit(AppGetPostsSuccessState());
            })
            .catchError((error){});
          }
    })
        .catchError((error) {
          emit(AppGetPostsErrorState(error.toString()));
    });
  }

  void postLikes(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true
    })
        .then((value) {
          emit(AppLikePostsSuccessState());
    })
        .catchError((error) {
          emit(AppLikePostsErrorState(error.toString()));
    });
  }

  List<UserModel>? users = [];

  void getAllUsers()
  {
    emit(AppGetAllUsersLoadingState());
    if(users!.isEmpty)
    {
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          for (var element in value.docs) {
            if(element.data()['uId'] != userModel!.uId)
            {
              users!.add(UserModel.fromJson(element.data()));
            }
          }
          emit(AppGetAllUsersSuccessState());
    })
        .catchError((error) {
          emit(AppGetAllUsersErrorState(error.toString()));
    });
    }
  }

  void sendMessage({
  required String receiverId,
  required String text,
  required String dateTime,
})
  {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      senderId: userModel!.uId,
      receiverId: receiverId,
    );
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(AppSendMessSuccessState());
    })
    .catchError((error) {
      emit(AppSendMessErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessSuccessState());
    })
        .catchError((error) {
      emit(AppSendMessErrorState());
    });

  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
      for (var element in event.docs)
      {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(AppGetMessSuccessState());
    });
  }

}