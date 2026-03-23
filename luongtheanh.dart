import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giới thiệu bản thân"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            // Ảnh đại diện
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                "",
              ),
            ),

            SizedBox(height: 15),

            // Tên
            Text(
              "Lương Thế Anh",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 5),

            // Nghề nghiệp
            Text(
              "Sinh viên CNTT",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 20),

            // Mô tả
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Xin chào! Tôi là sinh viên đam mê lập trình, đặc biệt là phát triển ứng dụng và bảo mật thông tin. Tôi đang học Flutter để xây dựng các ứng dụng di động hiện đại.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 25),

            // Thông tin liên hệ
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email"),
                    subtitle: Text("luongtheanh292@gmail.com"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text("SĐT"),
                    subtitle: Text("0969454962"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text("Địa chỉ"),
                    subtitle: Text("Ninh Bình, Việt Nam"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}