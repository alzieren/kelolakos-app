import 'package:flutter/material.dart';
import 'screens/room_list_screen.dart';

void main() {
  runApp(const KelolaKosApp());
}

class KelolaKosApp extends StatelessWidget {
  const KelolaKosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KelolaKos Mini App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const RoomListScreen(),
    );
  }
}
