package day6;
public class MethodTest5 {
	public static void main(String[] args) {
		System.out.println("main() 수행시작");
		int result = operate(10,20);
		System.out.println("호출 결과1 : "+result);
		System.out.println("호출 결과2 : "+operate(100,200));
		int result2 = operate(11,22) % 2;
		if(result2 == 0)
			System.out.println("호출 결과3 짝수");
		else
			System.out.println("호출 결과3 홀수");
		System.out.println("호출 결과4 : "+operate(100,200,300));
		System.out.println(getName());
		System.out.println("*" + getName() + "*");
		System.out.println("main() 수행종료");
	}	
	static int operate(int num1, int num2) { // 메서드 오버로딩
		return num1+num2;
	}
	static int operate(int num1, int num2, int num3) {
		return num1+num2+num3;
	}
	static String getName() {
		return "김정현";
	}
}







