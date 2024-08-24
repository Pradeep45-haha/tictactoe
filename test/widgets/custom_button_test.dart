import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/widgets/custom_button.dart';

void main() {
  testWidgets('Custom button widget testing', (tester) async {
    final customButton = MaterialApp(
      home: CustomButton(onTap: () {}, name: "Test"),
    );
    await tester.pumpWidget(customButton);

    expect(customButton, findsOneWidget);
  });
}
