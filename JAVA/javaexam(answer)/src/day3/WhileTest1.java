package day3;
public class WhileTest1 {
	public static void main(String[] args) {
		int sum = 0;
		int i = 0;		
		while(sum < 100){
			i = (int)(Math.random()*50)+1;
			sum += i;		
			System.out.println("sum = "+sum);			
		}		
	}
}




