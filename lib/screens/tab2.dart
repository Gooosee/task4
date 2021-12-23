import 'package:flutter/material.dart';
import 'package:task4/constants.dart';
import 'package:task4/model/rent.dart';
import 'package:task4/db/nodes_database.dart';

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> with AutomaticKeepAliveClientMixin<Tab2> {
  final controller = TextEditingController();
  late Rent articleRent;
  bool rentEmpty = true;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    if(rentEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Аренда'),
        ),
        body: Center(
          child: Column(
            children:
            [
              Text('Начало аренды', style: tahinaStyleBig1),
              Row(
                children: [
                  Expanded(child: buildTextField(context)),
                  const SizedBox(width: 12),
                  IconButton(icon: const Icon(Icons.qr_code_scanner),
                    onPressed: (){}, iconSize: 50,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  articleRent = NotesDatabase.instance.readNoteWithArticle(controller.text) as Rent;
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Card(
                      child: ListTile(
                        title: Text(articleRent.name, style: KTSR3StyleSmall1),
                      ),
                    ),
                  );
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Card(
                      child: ListTile(
                        title: Text(articleRent.rate.toString(), style: KTSR3StyleSmall1),
                        ),
                    ),
                  );
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Card(
                      child: ListTile(
                      title: Text(articleRent.place, style: KTSR3StyleSmall1),
                      ),
                    ),
                  );
                },
                child: const Text("Ввести артикул", style: tahinaStyleBig2),
              ),
            ]
          ),
        ),
    );
    }
  return Scaffold(
    appBar: AppBar(
      title: Text('Аренда'),
    ),
    body: Center(
      child: Text("Nothing"),
    ),
  );
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildTextField(BuildContext context) => TextField(
    controller: controller,
    style: tahinaStyleNormal1,
    decoration: InputDecoration(
      hintText: 'Артикул',
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );
}
