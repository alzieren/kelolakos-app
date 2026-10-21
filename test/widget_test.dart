import 'package:flutter_test/flutter_test.dart';
import 'package:p03_kelolakos/main.dart';

void main() {
  testWidgets('KelolaKos smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KelolaKosApp());
    expect(find.text('KelolaKos — Daftar Kamar'), findsOneWidget);
  });
}
