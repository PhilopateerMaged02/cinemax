// ignore_for_file: camel_case_types

abstract class cinemaxLoginStates {}

class cinemaxLoginInitialState extends cinemaxLoginStates {}

//Login States
class cinemaxLoginLoadingState extends cinemaxLoginStates {}

class cinemaxLoginSuccessState extends cinemaxLoginStates {}

class cinemaxLoginErrorState extends cinemaxLoginStates {}

class cinemaxChangePasswordVisibilityState extends cinemaxLoginStates {}
