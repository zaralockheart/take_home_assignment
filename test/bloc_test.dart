import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:take_home_assignment/blocs/bloc.dart';
import 'package:take_home_assignment/models/models.dart';
import 'package:take_home_assignment/service/service.dart';

class ClientMock extends Mock implements RestClient {}

void main() {
  AppBloc bloc;

  tearDown(() {
    bloc?.close();
  });

  test('Bloc fetching data', () {
    final client = ClientMock();
    bloc = AppBloc(client);

    final output = [
      Photo(
        albumId: 1,
        url: 'http://image.com',
        id: 1,
        thumbnailUrl: 'http://thumbnailurl.com',
        title: 'image title one',
      )
    ];

    when(client.getTasks(1)).thenAnswer((_) => Future.value(output));

    expectLater(
        bloc,
        emitsInOrder([
          AppState.initial(),
          AppState.initial().copyWith(albumOne: output),
        ]));

    bloc.add(GetPhotos(albumId: 1));
  });

  test('Bloc fetching data with error', () {
    final client = ClientMock();
    bloc = AppBloc(client);

    when(client.getTasks(1)).thenAnswer((_) => throw DioError());

    expectLater(
        bloc,
        emitsInOrder([
          AppState.initial(),
          AppState.initial().copyWith(hasError: true),
        ]));

    bloc.add(GetPhotos(albumId: 1));
  });

  test('Bloc fetching all data', () {
    final client = ClientMock();
    bloc = AppBloc(client);

    final output = [
      Photo(
        albumId: 1,
        url: 'http://image.com',
        id: 1,
        thumbnailUrl: 'http://thumbnailurl.com',
        title: 'image title one',
      )
    ];

    when(client.getTasks(1)).thenAnswer((_) => Future.value(output));
    when(client.getTasks(2)).thenAnswer((_) => Future.value(output));

    expectLater(
        bloc,
        emitsInOrder([
          AppState.initial(),
          AppState.initial().copyWith(albumOne: output),
          AppState.initial().copyWith(albumOne: output, albumTwo: output),
        ]));

    bloc.add(GetPhotos(albumId: 1));
    bloc.add(GetPhotos(albumId: 2));
  });
}
