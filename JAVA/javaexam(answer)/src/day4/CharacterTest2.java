package day4;
public class CharacterTest2 {
	public static void main(String[] args) {
		char v1 = '°¡';
		char v2 = 44032;//'\uAC00';   
		
		System.out.println(v1);
		System.out.println(v2);
		System.out.println((int)v1);
		System.out.println((int)v2);
		System.out.println((double)v1);
		System.out.println((double)v2);
	}
}
