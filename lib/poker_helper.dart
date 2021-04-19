import 'package:pokerpartner/card.dart';

class Poker {
  static final int STRAIGHT_FLUSH = 8000000;
  // + valueHighCard()
  static final int FOUR_OF_A_KIND = 7000000;
  // + Quads Card Rank
  static final int FULL_HOUSE = 6000000;
  // + SET card rank
  static final int FLUSH = 5000000;
  // + valueHighCard()
  static final int STRAIGHT = 4000000;
  // + valueHighCard()
  static final int THREE_OF_A_KIND = 3000000;
  // + Set card value
  static final int TWO_PAIRS = 2000000;
  // + High2*14^4+ Low2*14^2 + card
  static final int ONE_PAIR = 1000000;
  // + high*14^2 + high2*14^1 + low

  //Calculates the hand value
  static int valueHand(List<PlayingCard> hand) {
    if (isFlush(hand) && isStraight(hand))
      return valueStraightFlush(hand);
    else if (isFourOfAKind(hand))
      return valueFourOfAKind(hand);
    else if (isFullHouse(hand))
      return valueFullHouse(hand);
    else if (isFlush(hand))
      return valueFlush(hand);
    else if (isStraight(hand))
      return valueStraight(hand);
    else if (isThreeOfAKind(hand))
      return valueSet(hand);
    else if (isTwoPairs(hand))
      return valueTwoPairs(hand);
    else if (isOnePair(hand))
      return valueOnePair(hand);
    else
      return valueHighCard(hand);
  }

  static int valueStraightFlush(List<PlayingCard> hand) {
    sortByRank(hand);
    return STRAIGHT_FLUSH + valueHighCard(hand);
  }

  static int valueFlush(List<PlayingCard> hand) {
    sortByRank(hand);
    return FLUSH + valueHighCard(hand);
  }

  static int valueStraight(List<PlayingCard> hand) {
    sortByRank(hand);
    return STRAIGHT + valueHighCard(hand);
  }

  static int valueFourOfAKind(List<PlayingCard> hand) {
    sortByRank(hand);
    return FOUR_OF_A_KIND + valueHighCard(hand);
  }

  static int valueFullHouse(List<PlayingCard> hand) {
    sortByRank(hand);
    return FULL_HOUSE + valueHighCard(hand);
  }

  static int valueSet(List<PlayingCard> hand) {
    sortByRank(hand);
    return THREE_OF_A_KIND + valueHighCard(hand);
  }

  static int valueTwoPairs(List<PlayingCard> hand) {
    int handValue = 0;

    sortByRank(hand);

    if (hand[0].getRank() == hand[1].getRank() &&
        hand[2].getRank() == hand[3].getRank())
      handValue = 14 * 14 * hand[2].getRank() +
          14 * hand[0].getRank() +
          hand[4].getRank();
    else if (hand[0].getRank() == hand[1].getRank() &&
        hand[3].getRank() == hand[4].getIndex())
      handValue = 14 * 14 * hand[3].getRank() +
          14 * hand[0].getRank() +
          hand[2].getRank();
    else
      handValue = 14 * 14 * hand[3].getRank() +
          14 * hand[1].getRank() +
          hand[0].getRank();

    return TWO_PAIRS + handValue;
  }

  static int valueOnePair(List<PlayingCard> hand) {
    int handValue = 0;

    sortByRank(hand);

    if (hand[0].getRank() == hand[1].getRank())
      handValue = 14 * 14 * 14 * hand[0].getRank() +
          hand[2].getRank() +
          14 * hand[3].getRank() +
          14 * 14 * hand[4].getRank();
    else if (hand[1].getRank() == hand[2].getRank())
      handValue = 14 * 14 * 14 * hand[1].getRank() +
          hand[0].getRank() +
          14 * hand[3].getRank() +
          14 * 14 * hand[4].getRank();
    else if (hand[2].getRank() == hand[3].getRank())
      handValue = 14 * 14 * 14 * hand[2].getRank() +
          hand[0].getRank() +
          14 * hand[1].getRank() +
          14 * 14 * hand[4].getRank();
    else
      handValue = 14 * 14 * 14 * hand[3].getRank() +
          hand[0].getRank() +
          14 * hand[1].getRank() +
          14 * 14 * hand[2].getRank();

    return ONE_PAIR + handValue;
  }

  static int valueHighCard(List<PlayingCard> hand) {
    int handValue;

    sortByRank(hand);

    handValue = hand[0].getRank() +
        14 * hand[1].getRank() +
        14 * 14 * hand[2].getRank() +
        14 * 14 * 14 * hand[3].getRank() +
        14 * 14 * 14 * 14 * hand[4].getRank();

    return handValue;
  }

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

  //detects whether the Poker hand h contains a four of a kind
  //4 cards have the same rank
  //The last card can be of any rank
  // After sorting the cards by the rank, a Four of a Kind hand must be one of the following hands:
  // Lower ranked unmatched card + 4 cards of the same rank
  // 4 cards of the same rank + higher ranked unmatched card
  static bool isFourOfAKind(List<PlayingCard> hand) {
    bool firstSequence, secondSequence;

    if (hand.length != 5) return false;

    sortByRank(hand);

    //Check for: 4 cards of the same rank + higher ranked unmatched card
    firstSequence = hand[0].getRank() == hand[1].getRank() &&
        hand[1].getRank() == hand[2].getRank() &&
        hand[2].getRank() == hand[3].getRank();

    //Check for: lower ranked unmatched card + 4 cards of the same rank
    secondSequence = hand[1].getRank() == hand[2].getRank() &&
        hand[2].getRank() == hand[3].getRank() &&
        hand[3].getRank() == hand[4].getRank();

    return firstSequence || secondSequence;
  }

  //detects whether the Poker hand h contains a Full House
  //3 cards have the same rank   and
  //2 remaining cards have the same rank
  //After sorting
  //  3 lower ranked cards of same rank + 2 lower ranked cards of same rank
  //  2 lower ranked cards of same rank + 3 lower ranked cards of same rank
  static bool isFullHouse(List<PlayingCard> hand) {
    bool firstSequence, secondSequence;

    if (hand.length != 5) return false;

    sortByRank(hand);

    //Check for the 3 equal + 2 equal ( x x x y y )
    firstSequence = hand[0].getRank() == hand[1].getRank() &&
        hand[1].getRank() == hand[2].getRank() &&
        hand[3].getRank() == hand[4].getRank();

    //Check for the 2 equal + 3 equal( x x y y y )
    secondSequence = hand[0].getRank() == hand[1].getRank() &&
        hand[2].getRank() == hand[3].getRank() &&
        hand[3].getRank() == hand[4].getRank();

    return firstSequence || secondSequence;
  }

  //detects whether the Poker hand h contains a Three of a Kind
  // 3cards have the same rank
  // Plus 2 unmatched cards
  // After sorting the cards by the rank, a Three of a Kind hand must be one of the following hands:
  // A lower ranked unmatched card + another lower ranked unmatched card + 3 cards of the same rank
  // Lower ranked unmatched card + 3 cards of the same rank + a higher ranked unmatched card
  // 3 cards of the same rank + a higher ranked unmatched card + another higher ranked unmatched card
  static bool isThreeOfAKind(List<PlayingCard> hand) {
    bool firstSequence, secondSequence, thirdSequence;

    if (hand.length != 5) return false;

    sortByRank(hand);

    if (isFourOfAKind(hand) || isFullHouse(hand)) return false;

    //Check for sequence x x x a b
    firstSequence = hand[0].getRank() == hand[1].getRank() &&
        hand[1].getRank() == hand[2].getRank();

    // Check for sequence a x x x b
    secondSequence = hand[1].getRank() == hand[2].getRank() &&
        hand[2].getRank() == hand[3].getRank();

    // Check for sequence a b x x x
    thirdSequence = hand[2].getRank() == hand[3].getRank() &&
        hand[3].getRank() == hand[4].getRank();

    return firstSequence || secondSequence || thirdSequence;
  }

  //detects whether the Poker hand h contains 2 pairs
  // 2 cards have the same rank
  // 2 other cards have the same rank that is different from the first pair
  // the 5th card can be of any unmatched rank
  // After sorting the cards by the rank, a Two Pairs hand must be one of the following hands:
  // A lower ranked unmatched card + 2 cards of the same rank + 2 cards of the same rank
  // 2 cards of the same rank + 2 cards of the same rank + a higher ranked unmatched card
  // 2 cards of the same rank + a middle ranked unmatched card + 2 cards of the same rank
  static bool isTwoPairs(List<PlayingCard> hand) {
    bool firstSequence, secondSequence, thirdSequence;

    if (hand.length != 5) return false;

    if (isFourOfAKind(hand) || isFullHouse(hand) || isThreeOfAKind(hand))
      return false;

    sortByRank(hand);

    //Check a a b b x
    firstSequence = hand[0].getRank() == hand[1].getRank() &&
        hand[2].getRank() == hand[3].getRank();
    //Check x a a b b
    secondSequence = hand[1].getRank() == hand[2].getRank() &&
        hand[3].getRank() == hand[4].getRank();
    //Check a a x b b
    thirdSequence = hand[0].getRank() == hand[1].getRank() &&
        hand[3].getRank() == hand[4].getRank();
    return firstSequence || secondSequence || thirdSequence;
  }

  //detects whether the Poker hand h contains 1 pair
  // 2 cards have the same rank
  // The 3 other cards must be of unmatched rank
  // After sorting the cards by the rank, a One Pair hand must be one of the following hands:
  // 3 lower ranked unmatched cards + 2 cards of the same rank
  // 2 lower ranked unmatched cards + 2 cards of the same rank + 1 higher ranked unmatched card
  // 1 lower ranked unmatched card + 2 cards of the same rank + 2 higher ranked unmatched cards
  // 2 cards of the same rank + 3 higher ranked unmatched cards
  static bool isOnePair(List<PlayingCard> hand) {
    bool firstSequence, secondSequence, thirdSequence, fourthSequence;

    if (hand.length != 5) return false;

    if (isFourOfAKind(hand) ||
        isFullHouse(hand) ||
        isThreeOfAKind(hand) ||
        isTwoPairs(hand)) return false;

    sortByRank(hand);

    // Check a a x y z
    firstSequence = hand[0].getRank() == hand[1].getRank();

    // Check x a a y z
    secondSequence = hand[1].getRank() == hand[2].getRank();

    // Check x y a a z
    thirdSequence = hand[2].getRank() == hand[3].getRank();

    // Check x y z a a
    fourthSequence = hand[3].getRank() == hand[4].getRank();

    return firstSequence || secondSequence || thirdSequence || fourthSequence;
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
    int i, j, minJ;

    for (i = 0; i < hand.length; i++) {
      minJ = i;

      for (j = i + 1; j < hand.length; j++) {
        if (hand[j].getRank() < hand[minJ].getRank()) {
          minJ = j;
        }
      }
      PlayingCard help = hand[i];
      hand[i] = hand[minJ];
      hand[minJ] = help;
    }
  }
}
