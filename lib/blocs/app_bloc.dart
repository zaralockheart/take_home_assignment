import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:take_home_assignment/service/service.dart';

import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final RestClient client;

  AppBloc(this.client);

  @override
  AppState get initialState => AppState.initial();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is GetPhotos) {
      try {
        final data = await client.getTasks(event.albumId);
        if (event.albumId == 1) {
          yield state.copyWith(albumOne: data);
        } else {
          yield state.copyWith(albumTwo: data);
        }
      } catch (e) {
        yield state.copyWith(hasError: true);
      }
    }
  }
}
