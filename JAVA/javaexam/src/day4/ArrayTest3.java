package day4;
public class ArrayTest3 {
	public static void main(String[] args) {
		int a1[] = {3, 10, 2, 9, 5, 11, 12, 1};
		int max;
		// a1 배열변수에 할당된 배열의 요소중 최댓값
		max = a1[0];
		for(int i=1; i < a1.length; i++)
			if(a1[i] > max)
				max = a1[i];
		System.out.println("최댓값 : "+max);
		int min;
		// a1 배열변수에 할당된 배열의 요소중 최솟값
		min = a1[0];
		for(int i=1; i < a1.length; i++)
			if(a1[i] < min)
				min = a1[i];
		
		System.out.println("최솟값 : "+min);
		
	}
}








