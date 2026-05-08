class Run {
  final int? id;
  final int userId;
  final double distance;
  final int duration;
  final String date;

  Run({
    this.id,
    required this.userId,
    required this.distance,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'distance': distance,
      'duration': duration,
      'date': date,
    };
  }

  factory Run.fromMap(Map<String, dynamic> map) {
    return Run(
      id: map['id'],
      userId: map['userId'],
      distance: map['distance'],
      duration: map['duration'],
      date: map['date'],
    );
  }
}