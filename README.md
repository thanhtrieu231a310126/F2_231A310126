# Lab F2 Bố cục giao diện Flutter trên Android

Nguyễn Thị Thanh Triều — MSSV 231A310126. Project `f2_layout`, Material 3.

## Mở bằng Android Studio

Cài plugin Flutter (kèm Dart), chọn Open thư mục `f2_layout` (thư mục chứa pubspec.yaml), cấu hình Flutter SDK rồi chạy `lib/main.dart` trên máy Android. Không mở riêng thư mục android để sửa giao diện Flutter.

```sh
flutter pub get
flutter run
flutter analyze
flutter test --coverage
flutter build apk --debug
```

SDK dùng để kiểm tra: Flutter 3.47.5, Dart 3.13.4. APK debug dùng để thực hành, không phải bản phát hành cửa hàng.

## Đối chiếu yêu cầu

- Banner gradient cao 150, bo hai góc dưới; Stack/Positioned chồng avatar TT.
- Hai TextField có biểu tượng; mật khẩu có nút hiện/ẩn.
- Checkbox ghi nhớ, nút quên mật khẩu, đăng nhập hiện SnackBar mô phỏng.
- Divider/Expanded chia đều, nút tài khoản trường, liên kết đăng ký.
- ProfileCard có ba ListTile và hai ô thống kê dùng Expanded.
- SafeArea và SingleChildScrollView giữ nội dung cuộn khi bàn phím mở.
- LayoutBuilder: bề rộng vùng an toàn >=700 logical pixels dùng Row (3:2), dưới ngưỡng dùng Column. Xoay ngang chỉ chuyển hai cột khi đạt ngưỡng; thiết bị nhỏ có thể vẫn một cột.
- Hàng ghi nhớ xuống dòng khi form hẹp; FittedBox giữ chữ banner trong khối cao 150.
- NC1: theme/darkTheme và nút chuyển sáng tối.
- NC2: HeaderBanner, ProfileCard, StatBox trong lib/widgets, mỗi widget một file.

Tên/MSSV lấy từ bài trước. Lớp CNTT – LTDD và email 231A310126@vhu.edu.vn đang là thông tin minh họa theo mẫu đề, cần thay nếu khác. Hai chỉ số hồ sơ cũng là dữ liệu minh họa. Ghi nhớ chỉ đổi trạng thái giao diện, chưa lưu sau khi tắt app; đăng nhập không gọi máy chủ, đúng phạm vi lab bố cục.

`test/widget_test.dart` kiểm tra đăng nhập SnackBar, mật khẩu, checkbox, chế độ tối và mốc 320/699/700/900 với bàn phím giả lập. Báo cáo và video nằm trong submission; ảnh thật và log nằm trong evidence.
