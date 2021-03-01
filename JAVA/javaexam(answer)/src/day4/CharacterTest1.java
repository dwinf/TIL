package day4;
public class CharacterTest1 {
	public static void main(String[] args) {
		char v1 = 65;
		char v2 = 'A';   // ASCII
		char v3 = 0x41; // 영(공)엑스
		char v4 = '\u0041'; // 유니코드
		System.out.println(v1);
		System.out.println(v2);
		System.out.println(v3);
		System.out.println(v4);
		int v5 = 65;
		int v6 = 'A';
		int v7 = 0x41;
		int v8 = '\u0041';
		System.out.println(v5);
		System.out.println(v6);
		System.out.println(v7);
		System.out.println(v8);
		
		System.out.println(v1+1); // 이 연산을 수행해도 v1 변수의 값에는 변화 없다.
		System.out.println(v2+1);
		System.out.println(v3+1);
		System.out.println(v4+1);
		
		System.out.println((char)(v1+1));  // 이 연산을 수행해도 v1 변수의 값에는 변화 없다.

		System.out.println((char)(v2+1));
		System.out.println((char)(v3+1));
		System.out.println((char)(v4+1));
		
		System.out.println(++v1); // v1 = v1 + 1
		System.out.println(++v2);
		System.out.println(++v3);
		System.out.println(++v4);
		
		System.out.println(v1+=10);
		System.out.println(v2+=10);
		System.out.println(v3+=10);	
		System.out.println(v4+=10);	
	}
}
