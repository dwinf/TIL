package day9;

class A{
	A() {
		super();
		System.out.println("A Ŭ������ ��ü �����մϴ�.");
	}
}
class B extends A{
	B(int num) {
		super();
		System.out.println("B Ŭ������ ��ü �����մϴ�.");
	}
}
class C extends B{
	C() {
		super(100);
		System.out.println("C Ŭ������ ��ü �����մϴ�.");		
	}
}

public class ABCTest {
	public static void main(String[] args) {
		new C();

	}
}
