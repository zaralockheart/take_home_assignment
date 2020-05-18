import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_home_assignment/blocs/app_event.dart';
import 'package:take_home_assignment/blocs/bloc.dart';
import 'package:take_home_assignment/service/api_service.dart';
import 'package:take_home_assignment/utilities/hooks.dart';
import 'package:take_home_assignment/widget/choice_button.dart';
import 'package:take_home_assignment/widget/photos.dart';

void main() => runApp(MyApp());

/// Created by template. Since this is a single app page.
/// We initialize our [AppBloc] on top.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc(RestClient(Dio())),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Application(),
      ),
    );
  }
}

/// The only screen that we are going to show to user.
/// There is not design spec, only how to UI should look like.
/// Refer: Take Home Assignment.pdf
///
/// Here we are using [Hook] to handle stuff (such as widget lifecycle,
/// listening to state change).
class Application extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    final blocState = useBlocListener<AppBloc, AppState>();

    final page = useState(1);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<AppBloc>(context).add(GetPhotos(albumId: 1));
        BlocProvider.of<AppBloc>(context).add(GetPhotos(albumId: 2));
      });
      return null;
    }, [BlocProvider.of<AppBloc>(context)]);

    useEffect(() {
      if (blocState.hasError) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(
              context: context,
              builder: (dialogCtx) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Error fetching data'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Close'),
                        onPressed: () => Navigator.of(dialogCtx).pop(),
                      )
                    ],
                  ));
        });
      }
      return null;
    }, [blocState.hasError]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2]
                  .map((e) => InkWell(
                        onTap: () {
                          page.value = e;
                          pageController.jumpToPage(e - 1);
                        },
                        child: ChoiceButton(
                          selected: page.value == e,
                          index: e,
                        ),
                      ))
                  .toList(),
            ),
          ),
          if (blocState.albumOne == null || blocState.albumTwo == null)
            Container()
          else
            Expanded(
              // The main reason of why I decided to use Page View is to lazy
              // keep page state. To avoid the list view back to first position
              // when user change page.
              child: PageView(
                // I was not told whether to allow user scroll or not. Here I
                // assume that user is not suppose to scroll the page view.
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: <Widget>[
                  Photos(
                    key: Key('album one'),
                    data: blocState.albumOne,
                  ),
                  Photos(
                    key: Key('album two'),
                    data: blocState.albumTwo,
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
