// Harness minh họa riêng: cố ý bỏ vùng cuộn để quan sát RenderFlex overflow.
// Không dùng entry point này cho bản APK nộp.
import 'package:flutter/material.dart';
import '../lib/widgets/header_banner.dart';
void main() => runApp(MaterialApp(home: Scaffold(body: SafeArea(child: Column(children: [
 HeaderBanner(onToggleTheme: () {}),
 const Text('Minh họa bỏ SingleChildScrollView'),
 const SizedBox(height: 900, child: TextField(decoration: InputDecoration(labelText: 'MSSV'))),
])))));
