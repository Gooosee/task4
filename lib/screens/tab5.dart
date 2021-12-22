import 'package:flutter/material.dart';

class Tab5 extends StatefulWidget {
  @override
  _Tab5State createState() => _Tab5State();
}

class _Tab5State extends State<Tab5> with AutomaticKeepAliveClientMixin<Tab5> {
  @override
  void initState() {
    super.initState();
    print('initState Tab5');
  }

  @override
  Widget build(BuildContext context) {
    print('build Tab5');
    return Scaffold(
      appBar: AppBar(
        title: Text('Станции'),
      ),
      body: Center(

        child: Text(
          'This is content of Tab5',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
