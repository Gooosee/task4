import 'package:flutter/material.dart';
import 'package:task4/screens/tab1edit.dart';
import 'tab1edit.dart';
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
  List<String> lstback = ['Фамилия Имя Отчество', '+7(937)-145-77-25', 'a@gmail.com', '20 December, 2021'];
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),

        actions: <Widget>[
          const Center (
            child: Text('Баланс: 150 баллов', style: TextStyle(fontSize: 20, ), textAlign: TextAlign.center,),
          ),
          IconButton(onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tab1Edit(lstback)));
            setState(() {
              lstback = result;
              print(lstback);
            });
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: Column (
            children: [
              const SizedBox(height: 10,),
              const CircleAvatar(
                radius: 90,
                foregroundImage: AssetImage("images/avatar.jpg"),
              ),
              Text(lstback[0], style: tahinaStyleBig1),
              const Text('Статус: VIP (Скидка: 10%)', style: tahinaStyleBig2),
              const Text('Пол: Женский', style: tahinaStyleBig3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.call),
                    title: Text(lstback[1], style: KTSR3StyleSmall1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.mail),
                    title: Text(lstback[2], style: KTSR3StyleSmall1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text(lstback[3], style: KTSR3StyleSmall1),
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
