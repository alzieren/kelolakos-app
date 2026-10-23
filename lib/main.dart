import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/room_list_screen.dart';

void main() {
  runApp(const KelolaKosApp());
}

class KelolaKosApp extends StatelessWidget {
  const KelolaKosApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F46E5); // Indigo 600
    const secondaryColor = Color(0xFF06B6D4); // Cyan 500

    return MaterialApp(
      title: 'KelolaKos — Manajemen Kos Pintar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: secondaryColor,
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Slate 50
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F172A),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      home: const RoomListScreen(),
    );
  }
}

