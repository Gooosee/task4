import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:task4/screens/tab1.dart';

import '../constants.dart';



class Tab1Edit extends StatefulWidget {
  User us;
  Tab1Edit(this.us, {Key? key}) : super(key: key);

  @override
  _Tab1EditState createState() => _Tab1EditState(us);

}
class _Tab1EditState extends State<Tab1Edit> {
  User us;
  _Tab1EditState(this.us);

  DateTime selectedDate = DateTime(1900);

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

    User us1 = us;
    User lSave = us;
    if (selectedDate == DateTime(1900)) selectedDate = us.dob;
    var maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##', filter: { "#": RegExp(r'[0-9]') });
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(

      appBar: AppBar(
        title: const Text('Изменение'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          print(lSave);
          Navigator.of(context).pop(lSave);

        }),
        actions: const <Widget>[
          Icon(Icons.attach_money),
          Center (

            child: Text('150   ', textAlign: TextAlign.center,),
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
                  initialValue: us.name,
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: (String? value){
                    us1.name = value!;
                    debugPrint(value);
                  },
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }
                    return "Это поле не может быть пустым";
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.call),
                    title: TextFormField(inputFormatters: [maskFormatter],
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        labelText: 'Номер телефона *',
                        border: InputBorder.none,
                        hintText: '+7(777) 777-77-77'
                      ), style: KTSR3StyleSmall1,
                      initialValue: us.number,
                      onChanged: (String? value){
                        us1.number = value!;
                        debugPrint(value);
                      },
                        validator: (value) {
                          if (value != null && value.length == 17) {
                            return null;
                          }
                          return "Неверный номер";
                        }
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.mail),
                    title: TextFormField(style: KTSR3StyleSmall1, initialValue: us1.email, decoration: const InputDecoration(
                      labelText: 'Адрес электронной почты *',
                      border: InputBorder.none,
                      hintText: 'example@gmail.com'
                    ),
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (String? value){
                          us1.email = value!;
                          debugPrint(value);
                        },
                        validator: (value) {
                          if (value != null && value.isNotEmpty && value.contains('@') && value.contains('.')) {
                            return null;
                          }
                          return "Неверный адрес электронной почты";
                        })
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),

                child: Card(
                  child: ListTile(

                    leading: const Icon(Icons.date_range),

                    title: Text(DateFormat.yMMMMd('ru').format(selectedDate.toLocal()), style: KTSR3StyleSmall1),
                    trailing: IconButton(icon: const Icon(Icons.edit), onPressed: (){
                      _selectDate(context);
                    },),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(onPressed: (){
                  us1.dob = selectedDate;
                  Navigator.of(context).pop(us1);
                }, child: const Text("Сохранить", style: tahinaStyleBig2),),
              )
            ]
        ),
      ),

      )

    );

  }

  @override
  bool get wantKeepAlive => true;

}

