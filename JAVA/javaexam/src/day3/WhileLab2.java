package day3;

public class WhileLab2 {

	
		
		public static void main(String[] args) {
			int pairNum1=(int)(Math.random()*6)+1;
			int pairNum2=(int)(Math.random()*6)+1;

			
			while(pairNum1 != pairNum2) {
				if(pairNum1 > pairNum2)
					System.out.println(pairNum1+"이 "+pairNum2+" 보다 크다.");
				else
					System.out.println(pairNum1+"이 "+pairNum2+" 보다 작다.");
				pairNum1=(int)(Math.random()*6)+1;
				pairNum2=(int)(Math.random()*6)+1;
				
			}
			
			System.out.println("게임 끝.");
		}
			
		

	

}
