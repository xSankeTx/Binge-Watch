import 'package:binge_watch/Pages/Anime.dart';
import 'package:binge_watch/Pages/HomePage.dart';
import 'package:binge_watch/Pages/Series.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents{HomepageClickedEvent,AnimeClickedEvent,SeriesClickedEvent}

abstract class NavigationStates{}

class NavigationBloc extends Bloc<NavigationEvents,NavigationStates>{
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch(event){
      case NavigationEvents.HomepageClickedEvent: yield HomePage();
      break;
      case NavigationEvents.AnimeClickedEvent: yield Animepage();
      break;
      case NavigationEvents.SeriesClickedEvent: yield Seriespage();
      break;
    }
  }

}