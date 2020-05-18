import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_home_assignment/models/models.dart';
import 'package:take_home_assignment/utilities/utilities.dart';

class Photos extends StatefulWidget {
  final List<Photo> data;

  const Photos({Key key, this.data}) : super(key: key);

  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PhotoGrid(
      data: widget.data,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PhotoGrid extends HookWidget {
  final List<Photo> data;

  const PhotoGrid({this.data});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, orientation) => GridView.builder(
        itemCount: data?.length ?? 0,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isPortrait(orientation) ? 2 : 5,
          crossAxisSpacing: isPortrait(orientation) ? 0 : 4,
        ),
        itemBuilder: (_, index) {
          return Column(
            children: <Widget>[
              Expanded(child: Image.network(data[index].thumbnailUrl)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Text(
                  data[index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
