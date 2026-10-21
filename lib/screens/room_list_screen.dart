import 'package:flutter/material.dart';
import '../models/room.dart';
import '../widgets/room_card.dart';
import 'add_room_screen.dart';
import 'room_detail_screen.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  // Data list di memori (dimulai dengan 3 data awal)
  final List<Room> _rooms = [
    const Room(
      id: 'KOS-101',
      roomNumber: '101',
      roomType: 'Standard',
      monthlyPrice: 1200000,
      facilities: 'Kasur Single, Lemari, Meja Belajar, WiFi',
      isOccupied: true,
    ),
    const Room(
      id: 'KOS-102',
      roomNumber: '102',
      roomType: 'Deluxe',
      monthlyPrice: 1600000,
      facilities: 'AC, Kasur Queen, Kamar Mandi Dalam, Water Heater, WiFi',
      isOccupied: false,
    ),
    const Room(
      id: 'KOS-201',
      roomNumber: '201',
      roomType: 'VIP',
      monthlyPrice: 2200000,
      facilities: 'AC, Smart TV, Balkon Pribadi, Kulkas Mini, WiFi Cepat',
      isOccupied: false,
    ),
  ];

  Future<void> _navigateToAddRoom() async {
    // Navigasi maju ke Layar 3 dan menunggu objek Room kembali
    final newRoom = await Navigator.push<Room>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddRoomScreen(),
      ),
    );

    // Jika user menyimpan form (tidak membatalkan / back kosong)
    if (newRoom != null) {
      setState(() {
        _rooms.add(newRoom);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kamar ${newRoom.roomNumber} berhasil ditambahkan!'),
            backgroundColor: Colors.teal,
          ),
        );
      }
    }
  }

  Future<void> _navigateToDetail(Room room, int index) async {
    // Navigasi maju ke Layar 2 dan menunggu data terbaru jika ada update status
    final updatedRoom = await Navigator.push<Room>(
      context,
      MaterialPageRoute(
        builder: (context) => RoomDetailScreen(room: room),
      ),
    );

    if (updatedRoom != null) {
      setState(() {
        _rooms[index] = updatedRoom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableCount = _rooms.where((r) => !r.isOccupied).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KelolaKos — Daftar Kamar'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Total: ${_rooms.length} Kamar | Tersedia: $availableCount Kamar',
              style: TextStyle(
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: _rooms.isEmpty
          ? const Center(
              child: Text(
                'Belum ada kamar kos terdaftar.\nTekan tombol + untuk menambahkan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                final room = _rooms[index];
                return RoomCard(
                  room: room,
                  onTap: () => _navigateToDetail(room, index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddRoom,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Kamar'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
    );
  }
}
