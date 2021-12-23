import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task4/screens/tab1edit.dart';
import 'tab1edit.dart';
import '../constants.dart';
import 'package:xml/xml.dart' as xml;



class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  _Tab1State createState() => _Tab1State();
}

class User {
  User({
    required this.name,
    required this.number,
    required this.email,
    required this.dob,
    required this.balance,
  });

  String name;
  String number;
  String email;
  DateTime dob;
  double balance;
}

class _Tab1State extends State<Tab1> with AutomaticKeepAliveClientMixin<Tab1> {
  @override
  void initState() {
    super.initState();
  }
  User us = User(name: "Усачева Дарья Игоревна", number: '+7(999) 999-99-99', balance: 150, dob: DateFormat.yMMMMd('ru').parse("16 августа 1995 г."), email: 'usad@1c.ru');

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.xml');
  }



  writeXml(BuildContext context) async {
    final builder = xml.XmlBuilder();
    builder.element('data', nest: () {
      builder.element('name', nest: us.name);
      builder.element('number', nest: us.number);
      builder.element('email', nest: us.email);
      builder.element('dob', nest: DateFormat.yMMMMd('ru').format(us.dob));
      builder.element('balance', nest: us.balance);
      builder.element('rentFlag', nest: rentFlag.toString());
    });

    final bookshelfXml = builder.buildDocument();
    print(bookshelfXml);
    final file = await _localFile;
    await file.writeAsString(bookshelfXml.toString());


  }


  Future<User> readXml(BuildContext context) async {
    //writeXml(context);
    final file = await _localFile;
    var xmlString = await file.readAsString();
    var raw = xml.XmlDocument.parse(xmlString);

    Balance = double.parse(raw.findAllElements("balance").first.text);

    rentFlag = raw.findAllElements("rentFlag").first.text == 'true' ? true : false;
    return User(name: raw.findAllElements("name").first.text,
        number: raw.findAllElements("number").first.text,
        email: raw.findAllElements("email").first.text,
        dob: DateFormat.yMMMMd('ru').parse(raw.findAllElements("dob").first.text),
        balance: double.parse(raw.findAllElements("balance").first.text));



  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: <Widget>[

          const Icon(Icons.attach_money),
          Center (
            child: Text(Balance.toString(), textAlign: TextAlign.center,),
          ),
          IconButton(onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tab1Edit(us)));
            setState(() {

              us = result;
              writeXml(context);
            });
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<User>(
          future: readXml(context),
          builder: (context, data) {
            if (data.hasData) {
              print(1);
              us = data.data!;
              return Column (
                children: [
                  const SizedBox(height: 10,),
                  const CircleAvatar(
                    radius: 90,
                    foregroundImage: AssetImage("images/avatar.jpg"),
                  ),
                  Text(us.name, style: tahinaStyleBig1),
                  const Text('Статус: VIP (Скидка: 10%)', style: tahinaStyleBig2),
                  const Text('Пол: Женский', style: tahinaStyleBig3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.call),
                        title: Text(us.number, style: KTSR3StyleSmall1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.mail),
                        title: Text(us.email, style: KTSR3StyleSmall1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text(DateFormat.yMMMMd('ru').format(us.dob).toString(), style: KTSR3StyleSmall1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(onPressed: (){
                    }, child: Text(rentBut(), style: tahinaStyleBig2),
                  )
                  )]
            );
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        ),
      ),
    );
  }

  String rentBut(){
    if (rentFlag) {
      return "Взять в аренду";
    } else {
      return "Завершить";
    }
  }

  @override
  bool get wantKeepAlive => true;
}
