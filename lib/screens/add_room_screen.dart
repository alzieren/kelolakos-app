import 'package:flutter/material.dart';
import '../models/room.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();

  final _roomNumberController = TextEditingController();
  final _priceController = TextEditingController();
  final _facilitiesController = TextEditingController();

  String _selectedRoomType = 'Standard';
  bool _isOccupied = false;

  final List<String> _roomTypes = ['Standard', 'Deluxe', 'VIP'];

  @override
  void dispose() {
    _roomNumberController.dispose();
    _priceController.dispose();
    _facilitiesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validasi form sebelum mengirim data
    if (_formKey.currentState!.validate()) {
      final newRoom = Room(
        id: 'KOS-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        roomNumber: _roomNumberController.text.trim(),
        roomType: _selectedRoomType,
        monthlyPrice: int.parse(_priceController.text.trim()),
        facilities: _facilitiesController.text.trim(),
        isOccupied: _isOccupied,
      );

      // Kembalikan objek room baru ke layar sebelumnya
      Navigator.pop(context, newRoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kamar Kos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input 1: TextFormField (Nomor Kamar)
              TextFormField(
                controller: _roomNumberController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Kamar *',
                  hintText: 'Contoh: 101, A-02',
                  prefixIcon: Icon(Icons.meeting_room),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nomor kamar wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input 2: DropdownButtonFormField (Tipe Kamar)
              DropdownButtonFormField<String>(
                initialValue: _selectedRoomType,
                decoration: const InputDecoration(
                  labelText: 'Tipe Kamar *',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: _roomTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedRoomType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Input 3: TextFormField dengan tipe input angka (Harga Bulanan)
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga Sewa per Bulan (Rp) *',
                  hintText: 'Contoh: 1200000',
                  prefixIcon: Icon(Icons.payments),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga sewa tidak boleh kosong';
                  }
                  if (int.tryParse(value.trim()) == null) {
                    return 'Harga harus berupa angka valid';
                  }
                  if (int.parse(value.trim()) <= 0) {
                    return 'Harga sewa harus lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input 4: TextFormField multi-baris (Fasilitas)
              TextFormField(
                controller: _facilitiesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Fasilitas Kamar *',
                  hintText: 'Contoh: AC, Kasur Queen, Kamar Mandi Dalam, WiFi',
                  prefixIcon: Icon(Icons.star_border),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Fasilitas kamar tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Input 5: SwitchListTile (Status Awal)
              SwitchListTile(
                title: const Text('Status Langsung Terisi?'),
                subtitle: Text(
                  _isOccupied ? 'Kamar ditandai terisi penghuni' : 'Kamar kosong (siap huni)',
                ),
                value: _isOccupied,
                activeThumbColor: Colors.red.shade700,
                onChanged: (bool val) {
                  setState(() {
                    _isOccupied = val;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Tombol Submit
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Simpan Kamar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
