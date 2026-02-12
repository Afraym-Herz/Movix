import 'package:flutter_test/flutter_test.dart';
import 'package:movix/main.dart';

void main() {
  testWidgets('App shows Movix title', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Movix'), findsOneWidget);
  });
}
