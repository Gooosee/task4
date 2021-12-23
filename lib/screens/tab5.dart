import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

void main() => runApp(const Tab5());

class Tab5 extends StatelessWidget {
  const Tab5({Key? key}) : super(key: key);

  static const String _title = 'Обратная связь и FAQ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(_title),
        ),

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

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Item> _data = [Item(expandedValue: "Если на данный момент, у вас н"
      "ет активной аренды, то на главной вкладке будет кнопка 'Взять в аренду',"
      " иначе сначала придется завершить предыдущую аренду."
      " После нажатия на эту кнопку, вы сможете выбрать товар для аренды с"
      " помощью сканирования QR-кода или ввода артикула товара, после чего останется"
      " только нажать на кнопку 'Подтвердить начало аренды'", headerValue: "Как"
      " взять в аренду товар?"),
      Item(expandedValue: "Чтобы изменить данные о пользователе, нужно на "
          "главной вкладке нажать на шестеренку в верхнем правом углу экрана"
          " и в соответствующие поля ввести новые данные "
          "(изменения можно отменить, нажав на стрелку в верхнем левом"
          " углу экрана), после этого останется только нажать на"
          " кнопку сохранить.",
          headerValue: "Как изменить данные о пользователе?"),
      Item(expandedValue: "Посмотреть весь список товаров со станциями,"
        " на которых они находятся можно во вкладке 'Станции'.",
        headerValue: "Как посмотреть доступные в аренду товары рядом со мной?"),
      Item(expandedValue: "Посмотреть историю аренды можно во вкладке 'История'"
          " (четвертая по счету).",
          headerValue: "Где посмотреть историю?"),
      Item(expandedValue: "Это значит, что нужно вписать артикул товара в"
          " соответсутвующее поле (его можно найти во вкладке 'Станции')",
          headerValue: "Что значит “Ввести артикул”?"),
      Item(expandedValue: "Это значит, что нужно нажать на кнопку в виде"
          " QR-кода и сфотографировать код, тогда"
          " артикул введется автоматичекски.",
          headerValue: "Что значит “Отсканировать QR-код”?"),
      Item(expandedValue: "Для того, чтобы подтвердить у вас наличие товара.",
          headerValue: "Зачем мне делать фото?"),
      Item(expandedValue: "Жалобу можно написать выше, для этого нужно написать"
          " тему и текст жалобы, после этого нажать на кнопку 'Отправить'.",
          headerValue: "Как написать жалобу?"),
      Item(expandedValue: "Чтобы связаться с нами, можно просто написать "
          "сообщение в поддержку, для этого нужно написать"
          " тему и текст сообщения, после этого нажать на кнопку 'Отправить'.",
          headerValue: "Как с вами связаться??")];


  @override
  Widget build(BuildContext context) {
    List lst1 = ['', ''];
    return SingleChildScrollView(

      child: Column(
        children: [
          const Text("Обратная связь", style: tahinaStyleBig1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Card(
              child: ListTile(
                  leading: const Icon(Icons.mail),
                  title: TextFormField(style: KTSR3StyleSmall1, decoration: const InputDecoration(
                      labelText: 'Задайте вопрос',
                      border: InputBorder.none,
                      hintText: 'Тема письма'
                  ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: (String? value){
                        lst1[0] = value!;
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "Это поле не может быть пустым";
                      })
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Card(
              child: ListTile(
                  leading: const Icon(Icons.mail),
                  title: TextFormField(style: KTSR3StyleSmall1, decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Текст письма'
                  ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: (String? value){
                        lst1[1] = value!;
                      },
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return "Это поле не может быть пустым";
                      })
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(onPressed: (){
              sendMail(lst1);
            }, child: const Text("Отправить", style: tahinaStyleBig2),),
          ),
          _buildPanel(),
        ],
      ),
    );
  }
  sendMail(List lst) async {
    String username = 'arseniarsenitask@gmail.com';
    String password = 'qlzXeYRJe5nw';
    String domainSmtp = 'smtp.gmail.com';

    //also use for gmail smtp
    //final smtpServer = gmail(username, password);

    //user for your own domain
    final smtpServer = SmtpServer(domainSmtp,username: username,password: password,port: 587);
    String dt = DateFormat.yMMMMd('ru').format(DateTime.now().toLocal());
    final message = Message()
      ..from = Address(username, '<ФИО>')
      ..recipients.add('totsamigoose@gmail.com')
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Письмо от пользователя <ФИО>'
      ..text = '$dt Поступило письмо от пользователя \nНа тему "${lst[0]}"\nПисьмо: ${lst[1]}';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Widget _buildPanel() {
    return Column(
      children: [
        SizedBox(height: 10,),
        const Text("FAQ", style: tahinaStyleBig1),
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerValue, style: tahinaStyleNormal2),
                  subtitle:
                  const Text('Вопрос', style: KTSR3StyleSmall1),
                );
              },
              body: Column (
                  children : [
                      ListTile(
                        title: Text(item.expandedValue, style: KTSR3StyleSmall2,),
                        subtitle:
                        const Text('Ответ', style: KTSR3StyleSmall2),
                        onTap: () {
                        }),
                  ]
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ],
    );
  }
}
