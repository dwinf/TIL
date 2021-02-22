package day4;
public class ArrayTest2 {
	public static void main(String[] args) {
		int a1[] = new int[5];
		a1[0] = 33;
		a1[1] = 20;
		a1[2] = 15;
		a1[3] = 40;
		a1[4] = 7;
		System.out.println(a1[0]);
		System.out.println(a1[a1.length-1]);
		
		for(int i=a1.length-1; i >= 0; i--)
			System.out.print(a1[i]+" ");
		System.out.println();
		
		for(int i=0; i < a1.length; i+=2)
			System.out.print(a1[i]+" ");
		System.out.println();
		
	}
}








