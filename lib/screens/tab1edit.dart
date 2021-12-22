import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class Tab1Edit extends StatefulWidget {
  List<String> lst;
  Tab1Edit(this.lst, {Key? key}) : super(key: key);

  @override
  _Tab1EditState createState() => _Tab1EditState(lst);
}

class _Tab1EditState extends State<Tab1Edit> {
  List<String> lst;
  _Tab1EditState(this.lst);

  DateTime selectedDate = DateTime.now();


  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      fieldLabelText: 'Дата рождения',
      fieldHintText: 'Месяц/День/Год',
      errorFormatText: 'Дата в неверном формате',
      errorInvalidText: '',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> lst1 = lst;

    final ButtonStyle style =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    var controller = MaskedTextController(mask: '+0(000)-000-00-00');
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(

      appBar: AppBar(
        title: const Text('Изменение'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          lst1[3] = DateFormat.yMMMMd().format(selectedDate.toLocal());
          Navigator.of(context).pop(lst);
        }),
        actions: const <Widget>[

          Center (
            child: Text('Баланс: 150 баллов', style: TextStyle(fontSize: 20, ), textAlign: TextAlign.center,),
          ),

        ],
      ),
      body: SingleChildScrollView(
          child: Column (
            children: [
              SizedBox(height: 10,),
              const CircleAvatar(
                radius: 90,
                foregroundImage: AssetImage("images/avatar.jpg"),
              ),

               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(textAlign: TextAlign.center, style: tahinaStyleBig1, decoration: const InputDecoration(
                    labelText: 'ФИО *',
                ),
                  initialValue: lst[0],
                  onChanged: (String? value){
                    lst1[0] = value!;
                    debugPrint(value);
                  },
                  validator: (String? value) {
                    return (value == null) ? 'Это обязательное поле для ввода' : null;
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.call),
                    title: TextFormField(controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '+7(777)-777-77-77'
                      ), style: KTSR3StyleSmall1,
                      //initialValue: lst[1],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.mail),
                    title: TextFormField(style: KTSR3StyleSmall1, initialValue: lst1[2]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),

                child: Card(
                  child: ListTile(

                    leading: const Icon(Icons.date_range),

                    title: Text(DateFormat.yMMMMd().format(selectedDate.toLocal()), style: KTSR3StyleSmall1),
                    trailing: IconButton(icon: Icon(Icons.edit), onPressed: (){
                      _selectDate(context);
                    },),
                  ),
                ),
              ),
            ]
        ),
      ),

      )

    );

  }

  @override
  bool get wantKeepAlive => true;

}

