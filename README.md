# flutter_base
===========================================

Document:

Tìm hiểu mason tại: https://pub.dev/packages/mason_cli
Hướng dẫn cách thực hiện: https://youtu.be/-tNbw13b-1s

===========================================

Run:

1. Cách khởi chạy trực tiếp: (*)

run: mason make new_app -o test
(tạo app từ brick new_app tại tư thục test)

2. Cách khởi chạy qua github:
   Thêm dòng khai báo dưới đây vào mason.yaml
new_app:
   git:
   url: https://github.com/daoan1412/flutter_base.git
   path: bricks/new_app

run: mason make new_app -o test
Chú ý: Khi đặt tên project không sử dụng chữ in hoa vd: CIVAMS 
============================================

Update brick:

Các trường cần thay đổi như tên app, tên project, tên biến,... được thay đổi trong {{biến}} Khi thay
đổi, cập nhập lại brick bằng cách run: mason get Sau đó tạo lại file mới bằng Cách 1 (*)

=============================================

Setup Firebase: 

B1: Tạo lại file google-services.json
B2: Rebuil lại toàn bộ project, để cập nhập lại file google-services.json
https://stackoverflow.com/a/46257503/10621168
B3: Chạy câu lệnh: flutterfire configure
Sau khi run, cài đặt android, ios đúng với id của ứng dụng (com.example.vn) bằng tài khoản firebase 
File firebase_options.dart sẽ được sinh ra tự động trong lib

Lỗi có thể gặp: 
a firebase app named default already exists: https://stackoverflow.com/a/71644195/10621168

==============================================

Tổng quan Project trong brick new_app

1.Sử dụng mẫu giao diện của get_widget làm chủ đạo
https://pub.dev/packages/getwidget
https://docs.getwidget.dev/
2.Sử dụng flutter_form_builder để đồng bộ form nhập
https://pub.dev/packages/flutter_form_builder
3.Sử dụng Getx quản lý 





