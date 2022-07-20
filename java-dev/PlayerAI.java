public class PlayerAI {
   private String ai;
   private String human;
   private String[] board;

   public PlayerAI(String ai, String human, String[] board) {
      this.ai = ai;
      this.human = human;
      this.board = board;
   }

   public void nextMove() {
      int bestScore = Integer.MIN_VALUE;
      int bestIndex = nextAvailableIndex();

      if (bestIndex == -1) {
         return;
      }

      for (int i = 0; i < this.board.length; i++) {
         if (this.board[i].equals("")) {
            this.board[i] = this.ai;
            int score = minimax(0, Integer.MIN_VALUE, Integer.MAX_VALUE, false);
            this.board[i] = "";
            if (score > bestScore) {
               bestScore = score;
               bestIndex = i;
            }
         }
      }
      this.board[bestIndex] = this.ai;
   }

   private int minimax(int depth, int alpha, int beta, boolean isMax) {
      String currWinner = getWinner();

      if (currWinner.equals(human)) {
         return -10 + depth;
      } else if (currWinner.equals(ai)) {
         return 10 - depth;
      } else if (currWinner.equals("tie")) {
         return 0;
      }

      if (isMax) {
         int maxVal = Integer.MIN_VALUE;
         for (int i = 0; i < this.board.length; i++) {
            if (this.board[i].equals("")) {
               this.board[i] = this.ai;
               int val = minimax(depth + 1, alpha, beta, false);
               this.board[i] = "";
               maxVal = Math.max(maxVal, val);
               alpha = Math.max(alpha, val);
               if (beta <= alpha) {
                  break;
               }
            }
         }
         return maxVal;
      } else {
         int minVal = Integer.MAX_VALUE;
         for (int i = 0; i < this.board.length; i++) {
            if (this.board[i].equals("")) {
               this.board[i] = this.human;
               int val = minimax(depth - 1, alpha, beta, true);
               this.board[i] = "";
               minVal = Math.min(minVal, val);
               beta = Math.min(beta, val);
               if (beta <= alpha) {
                  break;
               }
            }
         }
         return minVal;
      }
   }

   private int nextAvailableIndex() {
      for (int i = 0; i < this.board.length; i++) {
         if (this.board[i].equals("")) {
            return i;
         }
      }
      return -1;
   }

   private String getWinner() {
      // check vertical
      // 0 3 6
      // 1 4 7
      // 2 5 8
      for (int i = 0; i < 3; i++) {
         String colMove1 = this.board[i];
         String colMove2 = this.board[i + 3];
         String colMove3 = this.board[i + 6];

         if (colMove1 == human && colMove2 == human && colMove3 == human) {
            return this.human;
         }

         if (colMove1 == ai && colMove2 == ai && colMove3 == ai) {
            return this.ai;
         }
      }

      // check horizontal
      // 0 1 2
      // 3 4 5
      // 6 7 8
      for (int i = 0; i <= 6; i += 3) {
         String rowMove1 = this.board[i];
         String rowMove2 = this.board[i + 1];
         String rowMove3 = this.board[i + 2];

         if (rowMove1 == human && rowMove2 == human && rowMove3 == human) {
            return this.human;
         }

         if (rowMove1 == ai && rowMove2 == ai && rowMove3 == ai) {
            return this.ai;
         }
      }

      // check diagonal
      // 0 4 8
      // 2 4 6
      String d1 = this.board[0];
      String d2 = this.board[4];
      String d3 = this.board[8];

      String d11 = this.board[2];
      String d22 = this.board[4];
      String d33 = this.board[6];

      if (d1 == human && d2 == human && d3 == human) {
         return this.human;
      }

      if (d11 == human && d22 == human && d33 == human) {
         return this.human;
      }

      if (d1 == ai && d2 == ai && d3 == ai) {
         return this.ai;
      }

      if (d11 == ai && d22 == ai && d33 == ai) {
         return this.ai;
      }

      // tie
      for (int i = 0; i < this.board.length; i++) {
         if (this.board[i].equals("")) {
            return "";
         }
      }
      return "tie";
   }
}
