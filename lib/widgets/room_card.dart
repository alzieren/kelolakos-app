import 'package:flutter/material.dart';
import '../models/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback? onTap;

  const RoomCard({
    super.key,
    required this.room,
    this.onTap,
  });

  IconData _getFacilityIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('ac')) return Icons.ac_unit_rounded;
    if (lower.contains('wifi')) return Icons.wifi_rounded;
    if (lower.contains('queen') || lower.contains('king')) return Icons.king_bed_rounded;
    if (lower.contains('kasur') || lower.contains('bed')) return Icons.single_bed_rounded;
    if (lower.contains('kamar mandi') || lower.contains('toilet') || lower.contains('wc')) {
      return Icons.shower_rounded;
    }
    if (lower.contains('heater') || lower.contains('air hangat')) return Icons.hot_tub_rounded;
    if (lower.contains('tv')) return Icons.tv_rounded;
    if (lower.contains('balkon')) return Icons.balcony_rounded;
    if (lower.contains('kulkas')) return Icons.kitchen_rounded;
    if (lower.contains('meja') || lower.contains('belajar')) return Icons.desk_rounded;
    if (lower.contains('lemari')) return Icons.checkroom_rounded;
    return Icons.check_circle_outline_rounded;
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'vip':
        return const Color(0xFFD97706); // Amber 600
      case 'deluxe':
        return const Color(0xFF7C3AED); // Violet 600
      default:
        return const Color(0xFF2563EB); // Blue 600
    }
  }

  Color _getTypeBgColor(String type) {
    switch (type.toLowerCase()) {
      case 'vip':
        return const Color(0xFFFEF3C7); // Amber 100
      case 'deluxe':
        return const Color(0xFFF3E8FF); // Violet 100
      default:
        return const Color(0xFFDBEAFE); // Blue 100
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOccupied = room.isOccupied;
    final statusBgColor = isOccupied ? const Color(0xFFFFF1F2) : const Color(0xFFECFDF5);
    final statusBorderColor = isOccupied ? const Color(0xFFFECDD3) : const Color(0xFFA7F3D0);
    final statusTextColor = isOccupied ? const Color(0xFFE11D48) : const Color(0xFF059669);
    final statusDotColor = isOccupied ? const Color(0xFFE11D48) : const Color(0xFF10B981);
    final statusText = isOccupied ? 'Terisi' : 'Tersedia';

    final typeColor = _getTypeColor(room.roomType);
    final typeBg = _getTypeBgColor(room.roomType);

    final facilities = room.facilityList;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          splashColor: const Color(0xFF4F46E5).withValues(alpha: 0.08),
          highlightColor: const Color(0xFF4F46E5).withValues(alpha: 0.04),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Room title + Room Type Tag + Status Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Room Number Avatar / Icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF4F46E5),
                            const Color(0xFF6366F1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.meeting_room_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Title & Type Badge
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Kamar ${room.roomNumber}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF0F172A),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Type pill
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: typeBg,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  room.roomType,
                                  style: TextStyle(
                                    color: typeColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'ID: ${room.id}',
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status Badge with glowing dot
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: statusBorderColor, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: statusDotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: statusTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12),

                // Facilities preview chips
                if (facilities.isNotEmpty) ...[
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: facilities.take(4).map((f) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getFacilityIcon(f),
                              size: 13,
                              color: const Color(0xFF64748B),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              f,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF475569),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                      ..addAll(
                        facilities.length > 4
                            ? [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '+${facilities.length - 4} lagi',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF64748B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ]
                            : [],
                      ),
                  ),
                  const SizedBox(height: 14),
                ],

                // Bottom row: Price on left, View detail CTA on right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Harga Sewa',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              'Rp ${room.formattedPrice}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF4F46E5),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const Text(
                              ' /bulan',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Action prompt
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lihat Detail',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4F46E5).withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 15,
                          color: Color(0xFF4F46E5),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

