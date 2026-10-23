class Room {
  final String id;
  final String roomNumber;
  final String roomType; // e.g. 'Standard', 'Deluxe', 'VIP'
  final int monthlyPrice;
  final String facilities;
  final bool isOccupied;

  const Room({
    required this.id,
    required this.roomNumber,
    required this.roomType,
    required this.monthlyPrice,
    required this.facilities,
    this.isOccupied = false,
  });

  Room copyWith({
    String? id,
    String? roomNumber,
    String? roomType,
    int? monthlyPrice,
    String? facilities,
    bool? isOccupied,
  }) {
    return Room(
      id: id ?? this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      roomType: roomType ?? this.roomType,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      facilities: facilities ?? this.facilities,
      isOccupied: isOccupied ?? this.isOccupied,
    );
  }

  String get formattedPrice {
    return monthlyPrice.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  List<String> get facilityList {
    return facilities
        .split(',')
        .map((f) => f.trim())
        .where((f) => f.isNotEmpty)
        .toList();
  }
}
