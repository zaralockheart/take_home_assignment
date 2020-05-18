import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class GetPhotos extends AppEvent {
  final int albumId;

  const GetPhotos({@required this.albumId});

  @override
  List<Object> get props => null;
}
