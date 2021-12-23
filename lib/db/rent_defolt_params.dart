import 'package:task4/db/nodes_database.dart';
import 'package:task4/model/rent.dart';

class RentDefolt {
  String name = 'Повербанк Альфа No100';
  int rate = 5;
  String place = 'Москва, 2-й Автозаводский проезд, 1/9';

  Future addRent() async {
    final rent = Rent(
      name: name,
      rate: rate,
      place: place,
      startDatetime: DateTime.now(),
      endDatetime: null,
      sum: null,
    );
    await NotesDatabase.instance.create(rent, "rent");
  }
}