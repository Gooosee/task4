import 'package:task4/db/nodes_database.dart';
import 'package:task4/model/rent.dart';

class RentDefolt {
  String name = 'Повербанк Кот No201';
  int rate = 6;
  String place = 'Москва, 2-й Автозаводский проезд, 1/9';
  String article = '333fff';

  Future addRent() async {
    final rent = Rent(
      name: name,
      rate: rate,
      place: place,
      startDatetime: DateTime.now(),
      endDatetime: null,
      sum: null,
      used: false,
      article: article,
    );
    await NotesDatabase.instance.create(rent, tableRent);
  }
}