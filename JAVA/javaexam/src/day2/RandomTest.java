package day2;
public class RandomTest {
	public static void main(String[] args) {
		double rand1 = Math.random();
		System.out.println(rand1);
		double rand2 = rand1 * 100;
		System.out.println(rand2); // 0.0 <= n < 1.0
		int rand3 = (int)rand2;
		System.out.println(rand3); // 0 ~ 99
		
		// rand1 을 가지고 1부터 6사이의 난수를 만드는 식을 구현하여
		// sixNum 변수에 담아서 출력해 보기
		int sixNum = (int)(rand1 * 6)+1;
		System.out.println(sixNum); 		
		// rand1 을 가지고 1부터 45사이의 난수를 만드는 식을 구현하여
		// lottoNum 변수에 담아서 출력해 보기
		int lottoNum = (int)(rand1 * 45)+1;
		System.out.println(lottoNum); 	
		
	}
}
