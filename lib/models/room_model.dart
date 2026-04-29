

class RoomModel {
  final String       roomNumber;
  final int          capacity;
  final String       type;        
  final String       status;     
  final String       block;
  final String       floor;
  final List<String> facilities;
  final double       monthlyFee;

  const RoomModel({
    required this.roomNumber,
    required this.capacity,
    required this.type,
    required this.status,
    required this.block,
    required this.floor,
    required this.facilities,
    required this.monthlyFee,
  });
}