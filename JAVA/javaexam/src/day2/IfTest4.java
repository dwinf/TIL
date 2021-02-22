package day2;

public class IfTest4 {
	public static void main(String[] args) {
		int score = (int)(Math.random()*101);
				
		if(score >= 90)
			System.out.println(score + " : A등급");
		else if(score >= 80)
			System.out.println(score + " : B등급");
		else if(score >= 70)
			System.out.println(score + " : C등급");
		else if(score >= 60)
			System.out.println(score + " : D등급");
		else
			System.out.println(score + " : F등급");	
		System.out.println("수행종료!!");
	}
}
