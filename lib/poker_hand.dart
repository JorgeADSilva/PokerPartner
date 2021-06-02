import 'package:pokerpartner/card.dart';
import 'package:pokerpartner/poker_helper.dart';

class PokerHand{
  List<PlayingCard> handCards;
  List<PlayingCard> bestCombination;
  int outs;
  int strength;
  int gameState; // 0 - flop | 1 - turn/river | 2 - river 

  PokerHand({this.handCards, this.bestCombination, this.outs, this.strength, this.gameState});

  void addCard(PlayingCard playingCard){
    if(bestCombination.length == 5) return;
    bestCombination.add(playingCard); 
    this.strength = Poker.valueHand(bestCombination);
    this.gameState++;
  }
}