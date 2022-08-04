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
