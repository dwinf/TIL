package day12;
public class AutoBoxingUnboxingTest {
	public static void main(String[] args) {
		Integer obj = new Integer(10);
		obj = 100;  // 기본 --> 객체 - 오토박싱
		int result = obj + 10; // 객체 --> 기본 - 오토언박싱
		System.out.println(result);
	}
}
