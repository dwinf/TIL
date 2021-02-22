package day3;
public class ForTest6 {
	public static void main(String[] args) {
		// A~Z 까지 출력해 보자
		char munja = 'A';
		for(int n=1; n <= 26; n++)
			System.out.print(munja++);
		System.out.println("\n------------");
		for(munja='A'; munja <= 'Z'; munja++)
			System.out.print(munja);
		System.out.println("\n------------");
		munja = 'A';
		for(int n=1; n <= 26; n++) {
			System.out.print(munja);
			munja += 1;
		}
		System.out.println("\n------------");
		munja = 'A';
		for(int n=1; n <= 26; n++) {
			System.out.print(munja);
			munja = (char)(munja + 1);
		}
	}
}






