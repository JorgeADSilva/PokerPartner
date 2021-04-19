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
      handState = Poker.isStraight(Constants.testStraightFlushHand) ? "Straight" : "None";
      handState += Poker.isFourOfAKind(Constants.testStraightFlushHand) ? "Four of a Kind" : "None";
      handState += Poker.isFullHouse(Constants.testStraightFlushHand) ? "Full House" : "None";
      handState += Poker.isFlush(Constants.testStraightFlushHand) ? "Flush" : "None";
      handState += Poker.isThreeOfAKind(Constants.testStraightFlushHand) ? "Three of a Kind" : "None";
      handState += Poker.isTwoPairs(Constants.testStraightFlushHand) ? "Two Pairs" : "None";
      handState += Poker.isOnePair(Constants.testStraightFlushHand) ? "One Pair" : "None";
      print(Poker.valueHand(Constants.testStraightFlushHand));
      print(Poker.valueHand(Constants.testOnePairhHand));
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayingCardWidget(pickedCard: Constants.testStraightFlushHand[0].toString()),
                PlayingCardWidget(pickedCard: Constants.testStraightFlushHand[1].toString()),
                PlayingCardWidget(pickedCard: Constants.testStraightFlushHand[2].toString()),
                PlayingCardWidget(pickedCard: Constants.testStraightFlushHand[3].toString()),
                PlayingCardWidget(pickedCard: Constants.testStraightFlushHand[4].toString()),
              ],
            ),
            Container(
                color: handState.contains("Straight") ? Colors.green : Colors.red,
                child: Text(" Straight ")),
            Container(
                color: handState.contains("Four of a Kind") ? Colors.green : Colors.red,
                child: Text(" Four of a Kind ")),
            Container(
                color: handState.contains("Full House") ? Colors.green : Colors.red,
                child: Text(" Full House ")),
            Container(
                color: handState.contains("Flush") ? Colors.green : Colors.red,
                child: Text(" Flush ")),
            Container(
                color: handState.contains("Three of a Kind") ? Colors.green : Colors.red,
                child: Text(" Three of a Kind ")),
            Container(
                color: handState.contains("Two Pairs") ? Colors.green : Colors.red,
                child: Text(" Two Pairs ")),
            Container(
                color: handState.contains("One Pair") ? Colors.green : Colors.red,
                child: Text(" One Pair ")),
            Text("TODO: IMPLEMENT HAND POINTS CALCULATION "),
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

