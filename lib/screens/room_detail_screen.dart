import 'package:flutter/material.dart';
import '../models/room.dart';
import '../widgets/room_card.dart';

class RoomDetailScreen extends StatefulWidget {
  final Room room;

  const RoomDetailScreen({
    super.key,
    required this.room,
  });

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  late Room _currentRoom;

  @override
  void initState() {
    super.initState();
    _currentRoom = widget.room;
  }

  void _toggleStatus() {
    setState(() {
      _currentRoom = _currentRoom.copyWith(
        isOccupied: !_currentRoom.isOccupied,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        Navigator.pop(context, _currentRoom);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Kamar ${_currentRoom.roomNumber}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, _currentRoom);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Penggunaan ulang custom widget RoomCard dengan data room
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RoomCard(room: _currentRoom),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Lengkap',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          icon: Icons.tag,
                          label: 'ID Sistem',
                          value: _currentRoom.id,
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.meeting_room,
                          label: 'Nomor Kamar',
                          value: _currentRoom.roomNumber,
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.category,
                          label: 'Tipe Kamar',
                          value: _currentRoom.roomType,
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.payments,
                          label: 'Harga Sewa',
                          value: 'Rp ${_currentRoom.monthlyPrice} / bulan',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.check_circle_outline,
                          label: 'Status Hunian',
                          value: _currentRoom.isOccupied ? 'Sedang Terisi' : 'Kosong (Tersedia)',
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          icon: Icons.star_border,
                          label: 'Fasilitas',
                          value: _currentRoom.facilities,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton.icon(
                  onPressed: _toggleStatus,
                  icon: Icon(_currentRoom.isOccupied ? Icons.person_off : Icons.person_add),
                  label: Text(
                    _currentRoom.isOccupied
                        ? 'Ubah Status: Tandai Kosong (Tersedia)'
                        : 'Ubah Status: Tandai Terisi',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: _currentRoom.isOccupied ? Colors.teal : Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, _currentRoom);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Kembali ke Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.indigo),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
