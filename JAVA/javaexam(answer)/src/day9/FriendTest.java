package day9;

class Person {
	private String name;
	Person(String name) {
		this.name = name;

	}
	public String getInfo() {
		return name;
	}
}
class Friend extends Person {
	private String phoneNum;
	private String email;
	Friend(String name, String phoneNum, String email) {
		super(name);
		this.phoneNum = phoneNum;
		this.email = email;
	}
	public String getInfo() {
		// return super.getInfo()+" "+phoneNum+" "+email;
		return String.format("%-20s%-20s%-20s\n", super.getInfo(), phoneNum, email);
	}
}

public class FriendTest {
	public static void main(String[] args) {
		Friend[] f = new Friend[5];
		f[0] = new Friend("��ũ", "1111", "test1@naver.com");
		f[1] = new Friend("�ν�", "2222", "test2@naver.com");
		f[2] = new Friend("�浿", "3333", "test3@naver.com");
		f[3] = new Friend("��", "4444", "test4@naver.com");
		f[4] = new Friend("��ġ", "5555", "test5@naver.com");

		System.out.printf("%-20s%-20s%-20s\n", "�̸�", "��ȭ��ȣ", "�����ּ�");
		System.out.println("-------------------------------------------");
		for (int i = 0; i < f.length; i++) {
			System.out.println(f[i].getInfo());
		}

	}

}
