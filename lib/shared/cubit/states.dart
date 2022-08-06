abstract class AppStates{}

class AppInitialState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}
class AppGetUserSuccessState extends AppStates {}
class AppGetUserErrorState extends AppStates
{
  final String error;

  AppGetUserErrorState(this.error);
}

class AppChangeBottomNavState extends AppStates {}

class AppAddPostState extends AppStates {}

class AppProfileImageSuccessState extends AppStates {}
class AppProfileImageErrorState extends AppStates {}

class AppCoverImageSuccessState extends AppStates {}
class AppCoverImageErrorState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates {}
class AppUploadProfileImageErrorState extends AppStates {}

class AppUploadCoverImageSuccessState extends AppStates {}
class AppUploadCoverImageErrorState extends AppStates {}

class AppUserUpdateLoadingState extends AppStates {}
class AppUserUpdateErrorState extends AppStates {}
