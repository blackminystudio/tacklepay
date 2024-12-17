import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/tokens/color_tokens.dart';
import 'package:tackleapp/widgets/buttons/toggle_button.dart';

import '../constants/key_constants.dart';

Widget buildToggleButton(bool value, Function(bool) onChanged) =>
    ScreenUtilInit(
      designSize: const Size(440, 956),
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          body: MinyToggleButton(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );

void main() {
  final toggleSliderFinder = find.byKey(toggleSliderFinderKey);
  final toggleBackgroundFinder = find.byKey(toggleBackgroundFinderKey);

  testWidgets(
      'Given initial value is false '
      'When toggle is pressed '
      'Then alignment changes to right and color is primary',
      (WidgetTester tester) async {
    var toggledValue = false;

    await tester.pumpWidget(
      buildToggleButton(toggledValue, (value) {
        toggledValue = value;
      }),
    );

    var buttonSlider = tester.widget<Container>(toggleSliderFinder);
    var buttonBackground =
        tester.widget<AnimatedContainer>(toggleBackgroundFinder);
    // Initial state check

    expect(toggledValue, isFalse);
    expect(buttonBackground.alignment, Alignment.centerLeft);
    expect(
      (buttonSlider.decoration as BoxDecoration).color,
      ColorTokens.secondary,
    );

    // Tap to change to true
    await tester.tap(find.byKey(toggleBackgroundFinderKey));
    await tester.pumpAndSettle();

    buttonSlider = tester.widget<Container>(toggleSliderFinder);
    buttonBackground = tester.widget<AnimatedContainer>(toggleBackgroundFinder);

    expect(toggledValue, isTrue);
    expect(buttonBackground.alignment, Alignment.centerRight);
    expect(
      (buttonSlider.decoration as BoxDecoration).color,
      ColorTokens.primary,
    );
  });

  testWidgets(
      'Given initial value is true '
      'When toggle is pressed '
      'Then alignment is back to left and color is secondary',
      (WidgetTester tester) async {
    var toggledValue = true;

    await tester.pumpWidget(
      buildToggleButton(toggledValue, (value) {
        toggledValue = value;
      }),
    );

    var buttonSlider = tester.widget<Container>(toggleSliderFinder);
    var buttonBackground =
        tester.widget<AnimatedContainer>(toggleBackgroundFinder);

    expect(toggledValue, isTrue);
    expect(buttonBackground.alignment, Alignment.centerRight);
    expect(
      (buttonSlider.decoration as BoxDecoration).color,
      ColorTokens.primary,
    );

    // Tap to change back to false
    await tester.tap(find.byKey(toggleBackgroundFinderKey));
    await tester.pumpAndSettle();

    buttonSlider = tester.widget<Container>(toggleSliderFinder);
    buttonBackground = tester.widget<AnimatedContainer>(toggleBackgroundFinder);

    expect(toggledValue, isFalse);
    expect(buttonBackground.alignment, Alignment.centerLeft);
    expect(
      (buttonSlider.decoration as BoxDecoration).color,
      ColorTokens.secondary,
    );
  });

  testWidgets(
      'Given initial value is false '
      'When toggle is pressed rapidly odd number of times '
      'Then alignment is right and color is primary without crashing',
      (WidgetTester tester) async {
    var toggledValue = false;

    await tester.pumpWidget(
      buildToggleButton(toggledValue, (value) {
        toggledValue = value;
      }),
    );
    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byKey(toggleBackgroundFinderKey));
      await tester.pumpAndSettle();
    }
    final buttonSlider = tester.widget<Container>(toggleSliderFinder);
    final buttonBackground =
        tester.widget<AnimatedContainer>(toggleBackgroundFinder);

    expect(toggledValue, isTrue);
    expect(buttonBackground.alignment, Alignment.centerRight);
    expect(
      (buttonSlider.decoration as BoxDecoration).color,
      ColorTokens.primary,
    );
  });
}
