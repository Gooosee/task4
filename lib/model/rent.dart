final String tableRent = 'rent';

class RentFields {
  static final List<String> values = [
    id, name, rate, place, startDatetime, endDatetime, sum
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String rate = 'rate';
  static final String place = 'place';
  static final String startDatetime = 'startDatetime';
  static final String endDatetime = 'endDatetime';
  static final String sum = 'sum';
}

class Rent {
  final int? id;
  final String name;
  final int rate;
  final String place;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final double sum;

  const Rent({
    this.id,
    required this.name,
    required this.rate,
    required this.place,
    required this.startDatetime,
    required this.endDatetime,
    required this.sum,
  });

  Rent copy({
  int? id,
  String? name,
  int? rate,
  String? place,
  DateTime? startDatetime,
  DateTime? endDatetime,
  double? sum,
  }) => Rent(
    id: id ?? this.id,
    name: name ?? this.name,
    rate: rate ?? this.rate,
    place: place ?? this.place,
    startDatetime: startDatetime ?? this.startDatetime,
    endDatetime: endDatetime ?? this.endDatetime,
    sum: sum ?? this.sum,
  );

  static Rent fromJson(Map<String, Object?> json) => Rent(
    id: json[RentFields.id] as int?,
    name: json[RentFields.name] as String,
    rate: json[RentFields.rate] as int,
    place: json[RentFields.place] as String,
    startDatetime: DateTime.parse(json[RentFields.startDatetime] as String),
    endDatetime: DateTime.parse(json[RentFields.endDatetime] as String),
    sum: json[RentFields.sum] as double,
  );

  Map<String, Object?> toJson() => {
    RentFields.id: id,
    RentFields.name: name,
    RentFields.rate: rate,
    RentFields.place: place,
    RentFields.startDatetime: startDatetime.toIso8601String(),
    RentFields.endDatetime: endDatetime.toIso8601String(),
    RentFields.sum: sum,
  };
}