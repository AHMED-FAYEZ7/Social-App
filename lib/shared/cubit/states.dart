abstract class AppStates{}

class AppInitialState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}
class AppGetUserSuccessState extends AppStates {}
class AppGetUserErrorState extends AppStates
{
  final String error;

  AppGetUserErrorState(this.error);
}

class AppGetAllUsersLoadingState extends AppStates {}
class AppGetAllUsersSuccessState extends AppStates {}
class AppGetAllUsersErrorState extends AppStates
{
  final String error;

  AppGetAllUsersErrorState(this.error);
}

class AppGetPostsLoadingState extends AppStates {}
class AppGetPostsSuccessState extends AppStates {}
class AppGetPostsErrorState extends AppStates
{
  final String error;

  AppGetPostsErrorState(this.error);
}

class AppLikePostsSuccessState extends AppStates {}
class AppLikePostsErrorState extends AppStates
{
  final String error;

  AppLikePostsErrorState(this.error);
}

class AppChangeBottomNavState extends AppStates {}

class AppAddPostState extends AppStates {}

class AppProfileImageSuccessState extends AppStates {}
class AppProfileImageErrorState extends AppStates {}

class AppCoverImageSuccessState extends AppStates {}
class AppCoverImageErrorState extends AppStates {}

class AppPostImageSuccessState extends AppStates {}
class AppPostImageErrorState extends AppStates {}
class AppRemovePostImageState extends AppStates {}


class AppUploadProfileImageSuccessState extends AppStates {}
class AppUploadProfileImageErrorState extends AppStates {}

class AppUploadCoverImageSuccessState extends AppStates {}
class AppUploadCoverImageErrorState extends AppStates {}

class AppUserUpdateLoadingState extends AppStates {}
class AppUserUpdateErrorState extends AppStates {}

class AppCreatePostLoadingState extends AppStates {}
class AppCreatePostSuccessState extends AppStates {}
class AppCreatePostErrorState extends AppStates {}


class AppSendMessSuccessState extends AppStates{}
class AppSendMessErrorState extends AppStates{}

class AppGetMessSuccessState extends AppStates{}
class AppGetMessErrorState extends AppStates{}
