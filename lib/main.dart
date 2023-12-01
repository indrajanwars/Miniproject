import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/pages/article.dart';
import 'package:miniproject/pages/login.dart';
import 'package:miniproject/pages/forumpage.dart';
import 'package:miniproject/pages/profilelist.dart';

void main() {
  runApp(const MyMiniProject());
}

class MyMiniProject extends StatelessWidget {
  const MyMiniProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      home: LoginPage(), // Halaman awal aplikasi adalah LoginPage.
      routes: {
        '/article': (context) =>
            ArticlePage(), // Rute untuk halaman ArticlePage.
        '/profilemenu': (context) =>
            ProfileMenuPage(), // Rute untuk halaman ProfileMenuPage.
        '/forum': (context) => ForumPage(), // Rute untuk halaman ForumPage.
      },
    );
  }
}
