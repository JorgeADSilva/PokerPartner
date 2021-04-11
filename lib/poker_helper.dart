import 'package:pokerpartner/card.dart';

class Poker {
  //
  // VARIABLES
  //

  //detects whether the Poker hand h contains a flush
  //Flush definition: There is one suit of cards in the Poker hand
  //Fr this we will start by sorting the cards first
  /*
  PSEUDO CODE
     Sort the cards in the Poker hand by the suit;

   if ( lowest suit == highest suit )
      Hand contain a flush (only 1 suit of cards in thehand !);      
   else
      Hand does not contain a flush;
  */
  static bool isFlush(List<PlayingCard> hand) {
    if (hand.length != 5) return false;
    sortBySuit(hand);

    return hand[0].getSuit() == hand[4].getSuit();
  }

  //detects whether the Poker hand h contains a straight
  //Straight Definition: The cards are increasing continuously in rank
  static bool isStraight(List<PlayingCard> hand) {
    int i, testRank;

    if (hand.length != 5) return false;

    sortByRank(hand); // Sort the poker hand by the rank of each card

    if (hand[4].getRank() == 14) {
      bool a = hand[0].getRank() == 2 &&
          hand[1].getRank() == 3 &&
          hand[2].getRank() == 4 &&
          hand[3].getRank() == 5;
      bool b = hand[0].getRank() == 10 &&
          hand[1].getRank() == 11 &&
          hand[2].getRank() == 12 &&
          hand[3].getRank() == 13;

      return (a || b);
    } else {
      testRank = hand[0].getRank() + 1;

      for (i = 1; i < 5; i++) {
        if (hand[i].getRank() != testRank) return false; // Straight failed...
        testRank++; // Next card in hand
      }

      return true; // Straight found !
    }
  }

  //detects whether the Poker hand h contains a straight
  static bool is4s(List<PlayingCard> hand) {
    return true;
  }

  //detects whether the Poker hand h contains a Full House
  static bool isFullHouse(List<PlayingCard> hand) {
    return true;
  }

  //detects whether the Poker hand h contains a Three of a Kind
  static bool is3s(List<PlayingCard> hand) {
    return true;
  }

  //detects whether the Poker hand h contains 2 pairs
  static bool is22s(List<PlayingCard> hand) {
    return true;
  }

  //detects whether the Poker hand h contains 1 pair
  static bool isOnePair(List<PlayingCard> hand) {
    return true;
  }

  //
  //HELPER METHODS
  //
  static void sortBySuit(List<PlayingCard> hand) {
    int i, j, minJ;
    for (i = 0; i < hand.length; i++) {
      //find array element with min value among the hand cards
      minJ = i;

      for (j = i + 1; j < hand.length; j++) {
        if (hand[j].getSuit() < hand[minJ].getSuit()) {
          minJ = j; // We found a smaller suit value, update min_j
        }
      }

      PlayingCard help = hand[i];
      hand[i] = hand[minJ];
      hand[minJ] = help;
    }
  }

  static void sortByRank(List<PlayingCard> hand) {
    int i, j, min_j;

    for (i = 0; i < hand.length; i++) {
      min_j = i;

      for (j = i + 1; j < hand.length; j++) {
        if (hand[j].getRank() < hand[min_j].getRank()) {
          min_j = j;
        }
      }
      PlayingCard help = hand[i];
      hand[i] = hand[min_j];
      hand[min_j] = help;
    }
  }
}
