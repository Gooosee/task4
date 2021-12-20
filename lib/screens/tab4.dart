import 'package:flutter/material.dart';

class Tab4 extends StatefulWidget {
  @override
  _Tab4State createState() => _Tab4State();
}

class _Tab4State extends State<Tab4> with AutomaticKeepAliveClientMixin<Tab4> {
  @override
  void initState() {
    super.initState();
    print('initState Tab4');
  }

  @override
  Widget build(BuildContext context) {
    print('build Tab4');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab4'),
      ),
      body: Center(
        child: Text(
          'This is content of Tab4',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
