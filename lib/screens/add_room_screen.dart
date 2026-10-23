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

  final List<String> _commonFacilities = [
    'AC',
    'WiFi',
    'Kamar Mandi Dalam',
    'Kasur Queen',
    'Water Heater',
    'Smart TV',
    'Lemari',
    'Meja Belajar',
    'Balkon',
    'Kulkas Mini',
  ];

  @override
  void dispose() {
    _roomNumberController.dispose();
    _priceController.dispose();
    _facilitiesController.dispose();
    super.dispose();
  }

  void _addFacilityTag(String facility) {
    final current = _facilitiesController.text.trim();
    if (current.isEmpty) {
      _facilitiesController.text = facility;
    } else {
      final items = current.split(',').map((e) => e.trim().toLowerCase()).toList();
      if (!items.contains(facility.toLowerCase())) {
        _facilitiesController.text = '$current, $facility';
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newRoom = Room(
        id: 'KOS-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
        roomNumber: _roomNumberController.text.trim(),
        roomType: _selectedRoomType,
        monthlyPrice: int.parse(_priceController.text.trim()),
        facilities: _facilitiesController.text.trim(),
        isOccupied: _isOccupied,
      );

      Navigator.pop(context, newRoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Kamar Kos Baru',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Form Container Card
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Pokok Kamar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Input 1: Nomor Kamar
                        TextFormField(
                          controller: _roomNumberController,
                          decoration: InputDecoration(
                            labelText: 'Nomor / Nama Kamar *',
                            hintText: 'Contoh: 101, A-02, Melati 3',
                            prefixIcon: const Icon(Icons.meeting_room_outlined, color: Color(0xFF4F46E5)),
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nomor kamar wajib diisi';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Input 2: Tipe Kamar (Modern Choice Chips)
                        const Text(
                          'Tipe Kamar *',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: _roomTypes.map((type) {
                            final isSelected = _selectedRoomType == type;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    setState(() {
                                      _selectedRoomType = type;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFF8FAFC),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFE2E8F0),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        type,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : const Color(0xFF334155),
                                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Input 3: Harga Sewa
                        TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Harga Sewa per Bulan (Rp) *',
                            hintText: 'Contoh: 1500000',
                            prefixIcon: const Icon(Icons.payments_outlined, color: Color(0xFF4F46E5)),
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Harga sewa tidak boleh kosong';
                            }
                            final parsed = int.tryParse(value.trim());
                            if (parsed == null || parsed <= 0) {
                              return 'Masukkan nominal angka valid lebih dari 0';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Input 4: Fasilitas + Quick Tags
                        TextFormField(
                          controller: _facilitiesController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Fasilitas Kamar *',
                            hintText: 'Pisahkan dengan tanda koma (cth: AC, WiFi, Lemari)',
                            prefixIcon: const Icon(Icons.star_outline_rounded, color: Color(0xFF4F46E5)),
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Fasilitas kamar tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Pilih cepat fasilitas untuk ditambahkan:',
                          style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _commonFacilities.map((facility) {
                            return ActionChip(
                              label: Text(
                                '+ $facility',
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                              backgroundColor: const Color(0xFFF1F5F9),
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              onPressed: () => _addFacilityTag(facility),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Input 5: Status Awal Switch
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: _isOccupied ? const Color(0xFFFFF1F2) : const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _isOccupied ? const Color(0xFFFECDD3) : const Color(0xFFA7F3D0),
                            ),
                          ),
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              _isOccupied ? 'Kamar Langsung Terisi' : 'Kamar Kosong (Tersedia)',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: _isOccupied ? const Color(0xFFBE123C) : const Color(0xFF047857),
                              ),
                            ),
                            subtitle: Text(
                              _isOccupied
                                  ? 'Penghuni sudah ada di kamar ini'
                                  : 'Kamar siap dipromosikan & disewakan',
                              style: TextStyle(
                                fontSize: 12,
                                color: _isOccupied ? const Color(0xFFE11D48) : const Color(0xFF059669),
                              ),
                            ),
                            value: _isOccupied,
                            activeThumbColor: const Color(0xFFE11D48),
                            onChanged: (bool val) {
                              setState(() {
                                _isOccupied = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.check_circle_rounded, size: 20),
                    label: const Text(
                      'Simpan Kamar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}

