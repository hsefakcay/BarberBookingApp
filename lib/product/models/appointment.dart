class Appointment {
  Appointment({
    required this.userId,
    required this.barberId,
    required this.date,
    required this.time,
    this.id,
  });

  // JSON'dan bir Appointment nesnesi oluşturma
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      barberId: json['barberId'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
    );
  }

  final String? id;
  final String userId;
  final String barberId;
  final String date;
  final String time;

  // Appointment nesnesini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'barberId': barberId,
      'date': date,
      'time': time,
    };
  }
}
