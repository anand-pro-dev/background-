import 'package:back_gournd_noti/bottam_index_screen.dart';
import 'package:back_gournd_noti/screens/custom_snakbar/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'APT Caller Application';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // background (button) color
            onPrimary: Colors.white, // foreground (text) color
          ),
        ),
      ),
      home: BottomIndexScreen(),
      // home: CustomSnackBar(),
    );
  }
}
