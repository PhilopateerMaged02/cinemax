abstract class cinemaxStates {}

class cinemaxInitialState extends cinemaxStates {}

class cinemaxChangeBottomNavStates extends cinemaxStates {}

//get upcoming movies
class cinemaxGetUpComingMoviesLoadingState extends cinemaxStates {}

class cinemaxGetUpComingMoviesSuccessState extends cinemaxStates {}

class cinemaxGetUpComingMoviesErrorState extends cinemaxStates {}
//get popular movies

class cinemaxGetoPopularMoviesLoadingState extends cinemaxStates {}

class cinemaxGetPopularMoviesSuccessState extends cinemaxStates {}

class cinemaxGetPopularMoviesErrorState extends cinemaxStates {}
