package day3;
public class ForTest8 {
	public static void main(String[] args) {
		for(int dan=1; dan <= 9; dan++) {
			for(int num=1; num <= 9; num++)
				System.out.print(dan+"x"+num+"="+dan*num+"\t");
			System.out.println();
		}		
	}
}
