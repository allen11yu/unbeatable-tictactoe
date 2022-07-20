import java.util.*;

public class Main {
   public static void main(String[] args) {
      Scanner scan = new Scanner(System.in);

      String[] board = { "", "", "", "", "", "", "", "", "" };
      String startFirst = "";
      String human = "";
      String ai = "";

      System.out.println("Welcome to Unbeatable Tic-Tac-Toe!");
      System.out.print("Would you like to start first? (Y/N): ");
      startFirst = scan.nextLine();
      System.out.print("Which symbol do you want to be? (X/O): ");
      human = scan.nextLine();
      ai = ((human.equals("X")) ? "O" : "X");

      PlayerAI computer = new PlayerAI(ai, human, board);
      while (getWinner(board, ai, human).equals("continue")) {
         if (startFirst.equals("N")) {
            computer.nextMove();
            triggerTurn(board, human, ai, scan, computer);
         } else {
            triggerTurn(board, human, ai, scan, computer);
            computer.nextMove();
         }
      }

      printBoard(board);
      System.out.println("Try again soon!");
   }

   public static void triggerTurn(String[] board, String human, String ai, Scanner scan, PlayerAI computer) {
      printBoard(board);
      System.out.println();
      System.out.print("Enter a slot: ");
      board[scan.nextInt()] = human;
   }

   public static void printBoard(String[] board) {
      for (int i = 0; i <= 6; i += 3) {
         for (int j = 0; j < 3; j++) {
            int index = i + j;
            if (board[index] == "") {
               System.out.print(index);
            } else {
               System.out.print(board[index]);
            }

            if (j != 2) {
               System.out.print("|");
            }
         }
         System.out.println();
      }
   }

   public static String getWinner(String[] board, String ai, String human) {
      // check vertical
      // 0 3 6
      // 1 4 7
      // 2 5 8
      for (int i = 0; i < 3; i++) {
         String colMove1 = board[i];
         String colMove2 = board[i + 3];
         String colMove3 = board[i + 6];

         if (colMove1 == human && colMove2 == human && colMove3 == human) {
            return human;
         }

         if (colMove1 == ai && colMove2 == ai && colMove3 == ai) {
            return ai;
         }
      }

      // check horizontal
      // 0 1 2
      // 3 4 5
      // 6 7 8
      for (int i = 0; i <= 6; i += 3) {
         String rowMove1 = board[i];
         String rowMove2 = board[i + 1];
         String rowMove3 = board[i + 2];

         if (rowMove1 == human && rowMove2 == human && rowMove3 == human) {
            return human;
         }

         if (rowMove1 == ai && rowMove2 == ai && rowMove3 == ai) {
            return ai;
         }
      }

      // check diagonal
      // 0 4 8
      // 2 4 6
      String d1 = board[0];
      String d2 = board[4];
      String d3 = board[8];

      String d11 = board[2];
      String d22 = board[4];
      String d33 = board[6];

      if (d1 == human && d2 == human && d3 == human) {
         return human;
      }

      if (d11 == human && d22 == human && d33 == human) {
         return human;
      }

      if (d1 == ai && d2 == ai && d3 == ai) {
         return ai;
      }

      if (d11 == ai && d22 == ai && d33 == ai) {
         return ai;
      }

      // tie
      for (int i = 0; i < board.length; i++) {
         if (board[i].equals("")) {
            return "continue";
         }
      }
      return "tie";
   }
}