package day7;


public class MemberTest {
	public static void main(String[] args) {
		Member p1 = new Member();
		Member p2 = new Member();
		Member p3 = new Member();
		p1.name = "둘리";
		p2.name = "마이콜";
		p3.name = "또치";
		p1.account = "깐따삐아";
		p2.account = "얼음별";
		p3.account = "생선";
		p1.passwd = "123";
		p2.passwd = "456";
		p3.passwd = "789";
		p1.birthyear = 1983;
		p2.birthyear = 1500;
		p3.birthyear = 1400;
		System.out.println("회원1 : " + p1.name + "(" + p1.account + ", " + p1.passwd + ", " + p1.birthyear + ")");
		System.out.println("회원2 : " + p2.name + "(" + p2.account + ", " + p2.passwd + ", " + p2.birthyear + ")");
		System.out.println("회원3 : " + p3.name + "(" + p3.account + ", " + p3.passwd + ", " + p3.birthyear + ")");
	}
}
