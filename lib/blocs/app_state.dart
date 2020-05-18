import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:take_home_assignment/models/models.dart';

class AppState extends Equatable {
  final List<Photo> albumOne;
  final List<Photo> albumTwo;
  final bool hasError;

  const AppState({
    @required this.albumOne,
    @required this.albumTwo,
    @required this.hasError,
  });

  factory AppState.initial() => AppState(
        albumOne: null,
        albumTwo: null,
        hasError: false,
      );

  AppState copyWith({
    List<Photo> albumOne,
    List<Photo> albumTwo,
    bool hasError,
  }) =>
      AppState(
        albumOne: albumOne ?? this.albumOne,
        albumTwo: albumTwo ?? this.albumTwo,
        hasError: hasError ?? this.hasError,
      );

  @override
  List<Object> get props => [
        albumOne,
        albumTwo,
        hasError,
      ];

 @override
  String toString() {
   return 'AppState(albumOne: $albumOne, albumTwo: $albumTwo, hasError: $hasError)';
  }
}
