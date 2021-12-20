import 'package:flutter/material.dart';

import '../constants.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> with AutomaticKeepAliveClientMixin<Tab1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),

        actions: const <Widget>[
          Center(
            child: Text('Баланс: 150 баллов', style: TextStyle(fontSize: 20, ), textAlign: TextAlign.center,),
          )
        ],
      ),
      body: Center(
        child: Column (
            children: [
              const SizedBox(height: 10,),
              const CircleAvatar(
                radius: 90,
                foregroundImage: AssetImage("images/avatar.jpg"),
              ),
              const Text('Фамилия Имя Отчество', style: tahinaStyleBig1),
              const Text('Статус: VIP (Скидка: 10%)', style: tahinaStyleBig2),
              const Text('Пол: Женский', style: tahinaStyleBig3),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.call),
                    title: Text("+7(937)145-77-25", style: KTSR3StyleSmall1),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("pochta@gmail.com", style: KTSR3StyleSmall1),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text("20 сентбря 2001 года", style: KTSR3StyleSmall1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(onPressed: (){
                }, child: const Text("Взять в аренду", style: tahinaStyleBig2),),
              )
            ]
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
