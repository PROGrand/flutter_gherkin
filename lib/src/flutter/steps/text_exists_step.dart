import 'package:flutter_gherkin_integration/flutter_gherkin.dart';
import 'package:flutter_gherkin_integration/src/flutter/adapters/app_driver_adapter.dart';
import 'package:gherkin/gherkin.dart';

import '../parameters/existence_parameter.dart';

/// Asserts the existence of text on the screen.
///
/// Examples:
///
///   `Then I expect the text "Logout" to be present`
///   `But I expect the text "Signup" to be absent`
StepDefinitionGeneric TextExistsStep() {
  return then2<String, Existence, FlutterWorld>(
    RegExp(r'I expect the text {string} to be {existence}$'),
    (text, exists, context) async {
      if (exists == Existence.present) {
        final isPresent = await context.world.appDriver.isPresent(
          context.world.appDriver.findBy(text, FindType.text),
        );

        context.expect(isPresent, true);
      } else {
        final isAbsent = await context.world.appDriver.isAbsent(
          context.world.appDriver.findBy(text, FindType.text),
        );
        context.expect(isAbsent, true);
      }
    },
  );
}
