import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task4/constants.dart';
import 'package:task4/db/nodes_database.dart';
import 'package:task4/model/rent.dart';
import 'package:task4/db/rent_defolt_params.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  List<String> expandedValue;
  String headerValue;
  bool isExpanded;
}

class Tab4 extends StatefulWidget {
  @override
  _Tab4State createState() => _Tab4State();
}

class _Tab4State extends State<Tab4> with AutomaticKeepAliveClientMixin<Tab4> {
  late List<Rent> rents;
  List<Item> _data = [];
  List<String> titles = ["Место", "Дата начала аренды", "Дата завершения аренды"];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  /*@override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }*/

  Future refresh() async {
    setState(() => isLoading = true);
    rents = await NotesDatabase.instance.readAllNotes(tableRent);
    setState(() => isLoading = false);
    if (rents.isEmpty) {
      RentDefolt().addRent();
    }
    for(int i = 0; i < rents.length; ++i){
      _data.add(
        Item(
          expandedValue: [
            rents[i].place,
            DateFormat.yMMMMd('ru').add_Hm().format(rents[i].startDatetime).toString(),
            rents[i].endDatetime != null ? DateFormat.yMMMMd('ru').add_Hm().format(rents[i].endDatetime!).toString() : '-',
          ],
          headerValue: rents[i].name + '\n' + DateFormat.yMMMMd('ru').add_Hm().format(rents[i].startDatetime).toString()
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('История'),
        ),
        body: Center(
          child: Column(
            children: [isLoading
                ? CircularProgressIndicator()
                : rents.isEmpty
                ? Text("Пусто", style: tahinaStyleBig1)
                : Container(
                  child: _buildPanel(),
              ),
          ])
        )
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue, style: tahinaStyleNormal1),
            );
          },
          body: Column (
              children : [
                for (int i = 0; i < item.expandedValue.length; ++i)
                  ListTile(
                      title: Text(titles[i], style: KTSR3StyleSmall1,),
                      subtitle:
                      Text(item.expandedValue[i], style: KTSR3StyleSmall1),
                      onTap: () {
                      }),
              ]
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
