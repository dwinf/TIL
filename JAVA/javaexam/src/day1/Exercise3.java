package day1;

public class Exercise3 {

	public static void main(String[] args) {
		char name1='k', name2='i', name3='m';
		System.out.println(name1+name2+name3);
		
		
		System.out.println(1+2+3+4+5+10);	// 25
		System.out.println(1+2+3+4+5-10);	// 5
		System.out.println((1+2+3+4+5)*10);	// 60
		System.out.println((1+2+3+4+5)/10);	// 10
		
		int result = 1+2+3+4+5; // result : ����
		System.out.println(result+10);
		System.out.println(result-10);
		System.out.println(result*10);
		System.out.println(result/10);
		
		char munja = 'A'; // 0x41, 65
		System.out.println(munja + munja); // 130
		
		System.out.println("" + munja + munja); // "" : �ι��ڿ� AA
		
		System.out.println(munja + munja + "");  // 130
	}

}
