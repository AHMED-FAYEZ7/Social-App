import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/register_states.dart';


class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() :super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      createUser(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });


  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uId,
})
  {
    UserModel model = UserModel(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      cover: 'https://images4.alphacoders.com/665/665374.jpg',
      bio: 'write your bio ...',
      image: 'https://images.wallpapersden.com/image/download/last-death-wish-anime_a2poZmmUmZqaraWkpJRmbmdlrWZlbWU.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(RegisterCreateUserSuccessState());
    }).catchError((error){
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassShown = true;

  void passVisibility()
  {
    isPassShown = !isPassShown;
    suffix = isPassShown ?
    Icons.visibility_outlined :
    Icons.visibility_off_outlined;

    emit(RegisterPassVisibilityState());
  }


}