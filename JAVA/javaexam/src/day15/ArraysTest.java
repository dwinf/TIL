package day15;

import java.util.Arrays;
import java.util.List;

public class ArraysTest {

	public static void main(String[] args) {
		int[] ary = { 2, 4, 3, 7, 21, 9, 98, 76, 74 };
		System.out.printf("ary 배열 원소들 : %s\n", Arrays.toString(ary));
		System.out.printf("ary 배열 크기 : %d\n", ary.length);

		Arrays.sort(ary);
		System.out.printf("소트후 ary 배열 원소들 : %s\n", Arrays.toString(ary));

		int idx = Arrays.binarySearch(ary, 21); 
		System.out.printf("21 이라는 값이 있는 원소의 인덱스 : %d\n\n", idx);

		int[] copyOfArray = Arrays.copyOf(ary, 11); 
		System.out.printf("copyOfArray 배열 크기: %d\n", copyOfArray.length);
		System.out.printf("copyOfArray 배열 원소들 : %s\n\n", Arrays.toString(copyOfArray));

		int[] copyOfRangeArray = Arrays.copyOfRange(ary, 5, 8); 
		System.out.printf("copyOfRangeArray  배열 원소들 : %s\n\n", Arrays.toString(copyOfRangeArray));

		int[] fillArray = new int[5]; 
		System.out.printf("fillArray (before): %s\n", Arrays.toString(fillArray));
		Arrays.fill(fillArray, 1);
		System.out.printf("fillArray (after): %s\n\n", Arrays.toString(fillArray));

		Integer[] objAry = new Integer[ary.length];
		for (int i = 0; i < ary.length; i++)
			objAry[i] = ary[i];
		List<Integer> integerList = Arrays.asList(objAry); 
		System.out.printf("리스트 크기 : %d\n", integerList.size());
		System.out.printf("리스트의 원소들 : ");
		for (Integer i : integerList) {
			System.out.printf("%d ", i);
		}
	}
}
