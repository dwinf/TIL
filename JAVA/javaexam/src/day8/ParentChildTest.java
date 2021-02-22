package day8;

class Parent {  // java.lang.Object	
	int x = 1, y = 2;
	public String toString() {
		return "Parent 클래스의 객체 입니당";
	}	
}
class Child extends Parent {
	int x = 10;
	void printInfo() {
		int x = 100;
		System.out.println(x);				// 100
		System.out.println(this.x);		// 10
		System.out.println(super.x);		// 1
		System.out.println(y);				// 2
		System.out.println(this.y);		//	2
		System.out.println(super.y);		// 2
		//System.out.println(z);
	}
	public String toString() {
		return "Child 클래스의 객체 입니당";
	}
}

public class ParentChildTest {
	public static void main(String[] args) {
		Parent p = new Parent();
		System.out.println(p.toString());
		System.out.println(p);
		System.out.println("출력 1" + p);
		Card c = new Card();
		System.out.println(c.toString());
		System.out.println("출력 2" + c);
		java.util.Date d = new java.util.Date();
		System.out.println(d.toString());
		System.out.println("출력 3" + d);
		Child ch = new Child();
		System.out.println("출력 4" + ch);
		ch.printInfo();
		System.out.println(ch.x);
		System.out.println(ch.y);
	}
}



