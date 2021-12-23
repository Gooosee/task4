import 'package:flutter/material.dart';
import 'package:task4/db/nodes_database.dart';
import 'package:task4/model/rent.dart';
import 'package:task4/db/rent_defolt_params.dart';

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> with AutomaticKeepAliveClientMixin<Tab2> {
  late List<Rent> rents;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refresh() async {
    setState(() => isLoading = true);
    rents = await NotesDatabase.instance.readAllNotes('rent');
    setState(() => isLoading = false);
    if (rents.isEmpty) {
      RentDefolt().addRent();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Аренда'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : rents.isEmpty
            ? Text("No rents")
            : Text("Rents"),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
