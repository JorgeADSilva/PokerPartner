import 'package:flutter/material.dart';
import 'package:pokerpartner/common.dart';
import 'package:pokerpartner/components/playing_card_widget.dart';
import 'package:pokerpartner/poker_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poker Helper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pickedCard = "AH";
  String handState = "None";

  void _testLogic() {
    print("------TEST-------");
    
    setState(() {
      handState = Poker.isFlush(Constants.test1_hand) ? "Flush" : "None";
      handState += Poker.isStraight(Constants.test1_hand) ? "Straight" : "None";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/' + pickedCard + '.jpg',
              height: 200,
            ),
            DropdownButton<String>(
              value: pickedCard,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  pickedCard = newValue;
                });
              },
              items: Constants.cardsList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Row(
              children: [
                PlayingCardWidget(pickedCard: Constants.test1_hand[0].toString()),
                PlayingCardWidget(pickedCard: Constants.test1_hand[1].toString()),
                PlayingCardWidget(pickedCard: Constants.test1_hand[2].toString()),
                PlayingCardWidget(pickedCard: Constants.test1_hand[3].toString()),
                PlayingCardWidget(pickedCard: Constants.test1_hand[4].toString()),
              ],
            ),
            Container(
                color: handState.contains("Flush") ? Colors.green : Colors.red,
                child: Text(" Flush ")),
            Container(
                color:
                    handState.contains("Straight") ? Colors.green : Colors.red,
                child: Text(" Straight ")),
            Text("TODO: IMPLEMENT THE REST.. "),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _testLogic,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

