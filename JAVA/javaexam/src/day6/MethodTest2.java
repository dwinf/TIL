package day6;
public class MethodTest2 {
	public static void main(String[] args) {
		System.out.println("main() 수행시작");
		printMyName(10);
		System.out.println("main() 수행종료");
	}	
	static void printMyName(int num) {
		for(int i=1; i <= num; i++)
			System.out.println("유니코");
	}
}
