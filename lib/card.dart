/* fully explicit card to integer conversions :
    
2c =  0    2d = 13    2h = 26    2s = 39
3c =  1    3d = 14    3h = 27    3s = 40
4c =  2    4d = 15    4h = 28    4s = 41
5c =  3    5d = 16    5h = 29    5s = 42
6c =  4    6d = 17    6h = 30    6s = 43
7c =  5    7d = 18    7h = 31    7s = 44
8c =  6    8d = 19    8h = 32    8s = 45
9c =  7    9d = 20    9h = 33    9s = 46
Tc =  8    Td = 21    Th = 34    Ts = 47
Jc =  9    Jd = 22    Jh = 35    Js = 48
Qc = 10    Qd = 23    Qh = 36    Qs = 49
Kc = 11    Kd = 24    Kh = 37    Ks = 50
Ac = 12    Ad = 25    Ah = 38    As = 51
*/

class PlayingCard {
  static const int CLUBS = 0;
  static const int DIAMONDS = 1;
  static const int HEARTS = 2;
  static const int SPADES = 3;

  static const int BAD_CARD = -1;
  static const int TWO = 0;
  static const int THREE = 1;
  static const int FOUR = 2;
  static const int FIVE = 3;
  static const int SIX = 4;
  static const int SEVEN = 5;
  static const int EIGHT = 6;
  static const int NINE = 7;
  static const int TEN = 8;
  static const int JACK = 9;
  static const int QUEEN = 10;
  static const int KING = 11;
  static const int ACE = 12;

  static const int NUM_SUITS = 4;
  static const int NUM_RANKS = 13;
  static const int NUM_CARDS = 52;

  int gIndex;

  //Creates an empty card
  PlayingCard({this.gIndex = 1});

  //
  //creates a card
  // @param rank face value of the card
  // @param suit suit of the card
  //
  PlayingCard.fromIntRankAndSuit(int rank, int suit) {
    gIndex = toIndex(rank, suit);
    print(gIndex);
  }

  PlayingCard.fromIndex(int index) {
    if (index >= 0 && index < NUM_CARDS)
      gIndex = index;
    else
      gIndex = BAD_CARD;
  }

  PlayingCard.fromString(String string) {
    if (string.length == 2) gIndex = chars2index(string[0], string[1]);
  }

  PlayingCard.fromStringRankAndSuit(String rank, String suit) {
    gIndex = chars2index(rank[0], suit[0]);
  }

  int getIndex() {
    return gIndex;
  }

  setIndex(int index) {
    gIndex = index;
  }

  ///
  /// convert a rank and a suit to an index
  /// @param rank the rank to convert
  /// @param suit the suit to convert
  /// @return the index calculated from the rank and suit
  ///
  static int toIndex(int rank, int suit) {
    return (NUM_RANKS * suit) + rank;
  }

  ///
  /// Change this card to another
  /// @param rank face value of the card
  /// @param suit suit of the card
  ///
  void setCard(int rank, int suit) {
    gIndex = toIndex(rank, suit);
  }

  ///
  ///Obtain the rank of the card
  ///returns the rank of the card
  ///
  int getRank() {
    return (this.gIndex % NUM_RANKS);
  }

  ///
  ///Obtain the rank of a certain card
  ///returns the rank of the card index
  ///
  int getCardRank(int index) {
    return (index % NUM_RANKS);
  }

  ///
  ///Obtain the suit of the card
  ///returns the suit of the card
  ///
  int getSuit() {
    return (this.gIndex ~/ NUM_RANKS);
  }

  ///
  ///Obtain the suit of a certain card
  ///returns the suit of the card index
  ///
  int getCardSuit(int index) {
    return (index ~/ NUM_RANKS);
  }

  ///
  ///Obtain the String representation of the current card
  ///@return a String for this card
  ///
  String toString() {
    String string = "";
    string += getRankString(getRank());
    switch (getSuit()) {
      case HEARTS:
        string += 'h';
        break;
      case DIAMONDS:
        string += 'd';
        break;
      case CLUBS:
        string += 'c';
        break;
      case SPADES:
        string += 's';
        break;
    }
    return string;
  }

  static String getRankString(int index) {
    String string;
    print("Index getRankString: " + index.toString());
    switch (index) {
      case ACE:
        string = 'A';
        break;
      case KING:
        string = 'K';
        break;
      case QUEEN:
        string = 'Q';
        break;
      case JACK:
        string = 'J';
        break;
      case TEN:
        string = 'T';
        break;
      case NINE:
        string = '9';
        break;
      case EIGHT:
        string = '8';
        break;
      case SEVEN:
        string = '7';
        break;
      case SIX:
        string = '6';
        break;
      case FIVE:
        string = '5';
        break;
      case FOUR:
        string = '4';
        break;
      case THREE:
        string = '3';
        break;
      case TWO:
        string = '2';
        break;
      default:
        string = 'X';
        break;
    }
    return string;
  }

  static int chars2index(String rank, String suit) {
    int r = -1;
    switch (rank[0]) {
      case '2':
        r = TWO;
        break;
      case '3':
        r = THREE;
        break;
      case '4':
        r = FOUR;
        break;
      case '5':
        r = FIVE;
        break;
      case '6':
        r = SIX;
        break;
      case '7':
        r = SEVEN;
        break;
      case '8':
        r = EIGHT;
        break;
      case '9':
        r = NINE;
        break;
      case 'T':
        r = TEN;
        break;
      case 'J':
        r = JACK;
        break;
      case 'Q':
        r = QUEEN;
        break;
      case 'K':
        r = KING;
        break;
      case 'A':
        r = ACE;
        break;
      case 't':
        r = TEN;
        break;
      case 'j':
        r = JACK;
        break;
      case 'q':
        r = QUEEN;
        break;
      case 'k':
        r = KING;
        break;
      case 'a':
        r = ACE;
        break;
    }
    int s = -1;
    switch (suit[0]) {
      case 'h':
        s = HEARTS;
        break;
      case 'd':
        s = DIAMONDS;
        break;
      case 's':
        s = SPADES;
        break;
      case 'c':
        s = CLUBS;
        break;
      case 'H':
        s = HEARTS;
        break;
      case 'D':
        s = DIAMONDS;
        break;
      case 'S':
        s = SPADES;
        break;
      case 'C':
        s = CLUBS;
        break;
    }
    if (s != -1 && r != -1)
      return toIndex(r, s);
    else
      return BAD_CARD;
  }
}
