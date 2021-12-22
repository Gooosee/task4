import 'package:flutter/material.dart';
import '../constants.dart';

void main() => runApp(const Tab3());

class Tab3 extends StatelessWidget {
  const Tab3({Key? key}) : super(key: key);

  static const String _title = 'Станции';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),

          actions: const <Widget>[
            Center(
              child: Text('Баланс: 150 баллов', style: TextStyle(fontSize: 20, ), textAlign: TextAlign.center,),
      )
      ],),

        body: const MyStatefulWidget(),
      ),
    );
  }
}

// stores ExpansionPanel state information
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


List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Станция $index',
      expandedValue: List<String>.generate(numberOfItems, (int index1){
        return 'Товар $index1';
      }),
    );
  });
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
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
              for (final x in item.expandedValue)
                ListTile(
                  title: Text(x, style: KTSR3StyleSmall1,),
                  subtitle:
                  const Text('Описание', style: KTSR3StyleSmall1),
                  onTap: () {
                  }),
            ]
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
