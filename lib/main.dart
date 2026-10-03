import 'package:flutter/material.dart';

import 'widgets/header_banner.dart';
import 'widgets/profile_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool dark = false;
  ThemeData makeTheme(Brightness brightness) => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0468D7),
      brightness: brightness,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'F2_231A310126',
    debugShowCheckedModeBanner: false,
    theme: makeTheme(Brightness.light),
    darkTheme: makeTheme(Brightness.dark),
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    home: LoginPage(onToggleTheme: () => setState(() => dark = !dark)),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onToggleTheme});
  final VoidCallback onToggleTheme;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _ghiNho = false;
  bool _anMatKhau = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // SingleChildScrollView: tránh lỗi tràn khi bàn phím hiện lên
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderBanner(onToggleTheme: widget.onToggleTheme),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 700;
                  final form = _buildForm(context);
                  final content = wide
                      ? Row(
                          key: const Key('wide-layout'),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: form),
                            const SizedBox(width: 24),
                            const Expanded(flex: 2, child: ProfileCard()),
                          ],
                        )
                      : Column(
                          key: const Key('narrow-layout'),
                          children: [
                            form,
                            const SizedBox(height: 24),
                            const ProfileCard(),
                          ],
                        );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: content,
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _notice(String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

  Widget _buildForm(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Đăng nhập hệ thống',
          style: textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Nhập MSSV và mật khẩu để tiếp tục',
          style: textTheme.bodyMedium?.copyWith(color: scheme.outline),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Mã số sinh viên',
            prefixIcon: Icon(Icons.badge_outlined),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          obscureText: _anMatKhau,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              tooltip: _anMatKhau ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
              icon: Icon(_anMatKhau ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _anMatKhau = !_anMatKhau),
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final remember = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: _ghiNho,
                  onChanged: (v) => setState(() => _ghiNho = v ?? false),
                ),
                const Flexible(child: Text('Ghi nhớ đăng nhập')),
              ],
            );
            final forgot = TextButton(
              onPressed: () =>
                  _notice('Liên hệ phòng đào tạo để cấp lại mật khẩu'),
              child: const Text('Quên mật khẩu?'),
            );
            if (constraints.maxWidth < 540) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  remember,
                  Align(alignment: Alignment.centerRight, child: forgot),
                ],
              );
            }
            return Row(children: [remember, const Spacer(), forgot]);
          },
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng nhập (mô phỏng) thành công')),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('ĐĂNG NHẬP'),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('hoặc', style: TextStyle(color: scheme.outline)),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => _notice('Đăng nhập tài khoản trường (mô phỏng)'),
          icon: const Icon(Icons.school_outlined),
          label: const Text('Đăng nhập bằng tài khoản trường'),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text('Chưa có tài khoản?'),
            TextButton(
              onPressed: () =>
                  _notice('Liên hệ nhà trường để đăng ký tài khoản'),
              child: const Text('Đăng ký'),
            ),
          ],
        ),
      ],
    );
  }
}
