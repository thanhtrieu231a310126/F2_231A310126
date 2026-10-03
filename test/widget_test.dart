import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f2_layout/main.dart';

void main() {
  testWidgets('Login interactions and dark theme', (t) async {
    t.view.physicalSize = const Size(430, 1200);
    t.view.devicePixelRatio = 1;
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(const MyApp());
    expect(find.text('Đăng nhập hệ thống'), findsOneWidget);
    await t.enterText(find.byType(TextField).last, 'secret');
    expect(t.widget<TextField>(find.byType(TextField).last).obscureText, true);
    await t.tap(find.byTooltip('Hiện mật khẩu'));
    await t.pump();
    expect(t.widget<TextField>(find.byType(TextField).last).obscureText, false);
    await t.tap(find.byType(Checkbox));
    await t.pump();
    expect(t.widget<Checkbox>(find.byType(Checkbox)).value, true);
    await t.tap(find.text('ĐĂNG NHẬP'));
    await t.pump();
    expect(find.text('Đăng nhập (mô phỏng) thành công'), findsOneWidget);
    await t.tap(find.byTooltip('Đổi chế độ sáng tối'));
    await t.pumpAndSettle();
    expect(
      t.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    expect(t.takeException(), isNull);
  });
  for (final w in [320.0, 699.0, 700.0, 900.0]) {
    testWidgets('Responsive $w and keyboard', (t) async {
      t.view.physicalSize = Size(w, 900);
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.resetPhysicalSize);
      addTearDown(t.view.resetDevicePixelRatio);
      await t.pumpWidget(const MyApp());
      expect(
        find.byKey(Key(w >= 700 ? 'wide-layout' : 'narrow-layout')),
        findsOneWidget,
      );
      t.view.viewInsets = const FakeViewPadding(bottom: 350);
      addTearDown(t.view.resetViewInsets);
      await t.pump();
      await t.ensureVisible(find.text('Email'));
      await t.pumpAndSettle();
      expect(t.takeException(), isNull);
    });
  }
}
