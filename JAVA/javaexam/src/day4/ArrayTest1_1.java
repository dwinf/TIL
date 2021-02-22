package day4;
public class ArrayTest1_1 {
	public static void main(String[] args) {
		int a1[] = new int[10];
		System.out.println(a1.length);
		int a2[] = {10, 20, 30};
		System.out.println(a2.length);
		
		for(int i=0; i < a1.length; i++)
			System.out.print(a1[i]+" ");
		System.out.println();
		for(int data : a1)
			System.out.print(data+" ");
		System.out.println();
		for(int i=0; i < a2.length; i++)
			System.out.print(a2[i]+" ");
		System.out.println();
		for(int data : a2)
			System.out.print(data+" ");
		System.out.println();
		
		for(int i=0; i < a1.length; i++)
			a1[i] = (i+1)*100;
		System.out.println();
		for(int i=0; i < a1.length; i++)
			System.out.print(a1[i]+" ");
		System.out.println();
		for(int data : a1)
			System.out.print(data+" ");
		
		//a2[3] = 100;
	}
}








