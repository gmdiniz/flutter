import 'package:bloc/bloc.dart';
import 'package:mytodolist/screens/archived.dart';
import 'package:mytodolist/screens/homepage.dart';
import 'package:mytodolist/screens/trash.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  ArchivedPageClickedEvent,
  TrashPageClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Homepage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield Homepage();
        break;
      case NavigationEvents.ArchivedPageClickedEvent:
        yield Archivedpage();
        break;
      case NavigationEvents.TrashPageClickedEvent:
        yield Trashpage();
        break;
    }
  }
}
