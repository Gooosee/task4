import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> with AutomaticKeepAliveClientMixin<Tab2> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Аренда'),
        ),
        body: Center(
          child: Text("Nothing"),
        ),
    );}

  @override
  bool get wantKeepAlive => true;
}
