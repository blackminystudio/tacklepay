import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:tackleapp/widgets/cards/greeting_card.dart';

void main() {
  group('GreetingCard Widget Tests', () {
    const testGreetingMessage = 'Hello, Welcome!';
    const testUserName = 'John';
    const testProfilePictureUrl = 'https://example.com/profile-picture.jpg';

    Widget createWidgetUnderTest({
      required String greetingMessage,
      required String userName,
      required String profilePictureUrl,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: GreetingCard(
                greetingMessage: greetingMessage,
                userName: userName,
                profilePictureUrl: profilePictureUrl,
              ),
            ),
          ),
        );

    testWidgets(
      'Given valid greeting message, user name, and profile picture URL '
      'when GreetingCard is rendered '
      'Then it should display the greeting message, username, profile picture',
      (WidgetTester tester) async {
        // Act
        await mockNetworkImagesFor(
          () async {
            await tester.pumpWidget(
              createWidgetUnderTest(
                greetingMessage: testGreetingMessage,
                userName: testUserName,
                profilePictureUrl: testProfilePictureUrl,
              ),
            );
          },
        );

        // Assert
        expect(find.text(testGreetingMessage), findsOneWidget);
        expect(find.text(testUserName), findsOneWidget);
        expect(find.byType(CircleAvatar), findsOneWidget);

        final avatarWidget =
            tester.widget<CircleAvatar>(find.byType(CircleAvatar));
        expect(avatarWidget.backgroundImage, isNotNull);
      },
    );

    testWidgets(
        'Given an empty profile picture URL '
        'when GreetingCard is rendered '
        'Then it should display a default placeholder for the profile picture',
        (WidgetTester tester) async {
      // Arrange
      const emptyProfilePictureUrl = '';

      // Act
      await mockNetworkImagesFor(
        () async {
          await tester.pumpWidget(
            createWidgetUnderTest(
              greetingMessage: testGreetingMessage,
              userName: testUserName,
              profilePictureUrl: emptyProfilePictureUrl,
            ),
          );
        },
      );
      // Assert
      final avatarWidget =
          tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatarWidget.backgroundImage, isNull);
    });
  });
}
