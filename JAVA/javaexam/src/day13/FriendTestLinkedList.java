package day13;

import java.util.Iterator;
import java.util.LinkedList;

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
		return String.format("%s\t%s\t%s", super.getInfo(), phoneNum, email);
	}
}

public class FriendTestLinkedList {

	public static void main(String[] args) {
		LinkedList<Friend> friend = new LinkedList<>();
		friend.add(new Friend("둘리", "010 1234 5678", "dool2@naver.com"));
		friend.add(new Friend("도우너", "010 5678 1234", "donut@naver.com"));
		friend.add(new Friend("또치", "010 2580 3691", "chick@naver.com"));
		friend.add(new Friend("희동이", "010 3214 6547", "hoit@naver.com"));
		friend.add(new Friend("마이콜", "010 7755 3311", "lalala@naver.com"));

		System.out.println("이름            전화번호                     메일주소");
		System.out.println("------------------------------------------");

		for (int i = 0; i < friend.size(); i++) {
			Friend info = friend.get(i);
			System.out.println(info.getInfo());
		}
		System.out.println();

		for(Friend value : friend) {
			System.out.println(value.getInfo());
		}
		System.out.println();

		Iterator<Friend> iter = friend.iterator();
		while(iter.hasNext()){
			Friend s = iter.next();
			System.out.println(s.getInfo());
		}
	}

}
