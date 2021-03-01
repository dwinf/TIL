package day3;
public class ForTest5 {
	public static void main(String[] args) {
		// 10부터 1까지의 숫자에 대하여 숫자값과 해당 숫자의 제곱값을
		// 행단위로 출력해 보자.
		for(int n=10; n >= 1; n--)
			System.out.println(n + " : " + n*n);
		System.out.println("------------");
		// 10 부터 20까지의 숫자에 대하여 3씩 증가시키면서 숫자값과 
		//해당 숫자의 제곱값을 행단위로 출력해 보자.
		for(int n=10; n <= 20; n+=3)
			System.out.println(n + " : " + n*n);
		System.out.println("------------");
	}
}
