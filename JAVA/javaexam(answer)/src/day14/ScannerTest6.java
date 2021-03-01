package day14;

import java.util.Scanner;
import java.io.File;
public class ScannerTest6 {
   public static void main(String[] args) throws Exception {	
      Scanner sc1 = new Scanner(new File("data.txt"));
      int cnt = 0;
      int totalSum = 0;     
      while (sc1.hasNextLine()) {
         String line = sc1.nextLine();
         Scanner sc2 = new Scanner(line).useDelimiter(" ");
	     int sum = 0;
  	     while(sc2.hasNextInt()) {
	        sum += sc2.nextInt();
	     }
	     System.out.println(line + ", sum = "+ sum);
	     totalSum += sum;
	     cnt++;
      }     
      System.out.println("Line: " + cnt + ", Total: " + totalSum);
      sc1.close();
   }
}

