import 'package:bloc/bloc.dart';
import 'pick_location_event.dart';
import 'pick_location_state.dart';

class PickLocationBloc extends Bloc<PickLocationEvent, PickLocationState> {
  @override
  PickLocationState get initialState => LocationFetched(heatMapItems: []);

  @override
  Stream<PickLocationState> mapEventToState(
   PickLocationEvent event,
  ) async* {
    if(event is LocationPicked){

    }
  }
}