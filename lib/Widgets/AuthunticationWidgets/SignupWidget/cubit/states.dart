abstract class cinemaxRegisterStates {}

//initial state
class cinemaxRegisterInitialState extends cinemaxRegisterStates {}

//Register a new user using Firebase
class cinemaxRegisterLoadingState extends cinemaxRegisterStates {}

class cinemaxRegisterSuccessState extends cinemaxRegisterStates {}

class cinemaxRegisterErrorState extends cinemaxRegisterStates {}

//change suffix of password text field
class cinemaxChangePasswordVisibilityState extends cinemaxRegisterStates {}
