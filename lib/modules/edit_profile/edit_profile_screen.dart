
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../shared/componants/componants.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var userModel = AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: defaultTextButton(
                  text: 'Update',
                  function: ()
                  {
                    AppCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                    );
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is AppUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if(state is AppUserUpdateLoadingState)
                    const SizedBox(height: 5,),
                  Container(
                    height: 210,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null ? NetworkImage(
                                      '${userModel.cover}',
                                    ) : FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: ()
                                {
                                  AppCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 22,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                ),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null ? NetworkImage(
                                    '${userModel.image}'
                                ) : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                AppCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 22,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  if(AppCubit.get(context).profileImage != null
                      || AppCubit.get(context).coverImage != null)
                    Row(
                    children: [
                      if(AppCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                              radius: 5,
                                function: ()
                                {
                                  AppCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                  );
                                },
                                text: 'upload profile',
                              ),
                              if(state is AppUserUpdateLoadingState)
                                const SizedBox(height: 5,),
                              if(state is AppUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                      ),
                      const SizedBox(width: 10,),
                      if(AppCubit.get(context).coverImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                              radius: 5,
                              function: ()
                              {
                                AppCubit.get(context).uploadCoverImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              },
                              text: 'upload cover',
                            ),
                            if(state is AppUserUpdateLoadingState)
                              const SizedBox(height: 5,),
                            if(state is AppUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (s)
                    {
                      if(s!.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(height: 10,),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validator: (s)
                    {
                      if(s!.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(height: 10,),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validator: (s)
                    {
                      if(s!.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
