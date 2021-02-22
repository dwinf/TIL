package day14;
class Member1 {
	private int id;
	private String name;
	private String password;
	Member1(int id, String name, String password) {
		this.id = id;
		this.name = name;
		this.password = password;
	}
}
public class ObjectTest1 {
	public static void main(String args[]) {
		Member1 obj1 = new Member1(10, "자바", "duke");
		Member1 obj2 = new Member1(10, "자바", "duke");

		System.out.println(obj1.equals(obj2));	// f
		System.out.println(obj1 == obj2);			// f
		
		Member1 obj3 = obj2;
		System.out.println(obj3.equals(obj2));	// t
		System.out.println(obj3 == obj2);			// t
	}
}

