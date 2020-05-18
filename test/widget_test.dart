import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';
import 'package:take_home_assignment/blocs/app_bloc.dart';
import 'package:take_home_assignment/main.dart';
import 'package:take_home_assignment/models/models.dart';

import 'bloc_test.dart';

void main() {
  testWidgets(
    'Smoke test fetch api and display',
    (WidgetTester tester) async {
      final client = ClientMock();

      final output = [
        Photo(
          albumId: 1,
          url: 'http://image.com',
          id: 1,
          thumbnailUrl: 'http://thumbnailurl.com',
          title: 'image title one',
        )
      ];

      final output2 = [
        Photo(
          albumId: 1,
          url: 'http://image.com',
          id: 1,
          thumbnailUrl: 'http://thumbnailurl.com',
          title: 'image title two',
        )
      ];

      when(client.getTasks(1)).thenAnswer((_) => Future.value(output));
      when(client.getTasks(2)).thenAnswer((_) => Future.value(output2));

      provideMockedNetworkImages(() async {
        await tester.pumpWidget(BlocProvider<AppBloc>(
          create: (_) => AppBloc(client),
          child: MaterialApp(
            home: Application(),
          ),
        ));

        await tester.pump();

        final buttonTwo = find.text('2');
        expect(find.text('1'), findsOneWidget);
        expect(buttonTwo, findsOneWidget);

        // Find the image title on page 1.
        expect(find.text('image title one'), findsOneWidget);

        await tester.tap(buttonTwo);

        await tester.pumpAndSettle();

        // Find the image title on page 2.
        expect(find.text('image title two'), findsOneWidget);
      });
    },
  );
}
