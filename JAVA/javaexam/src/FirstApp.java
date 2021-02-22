import java.util.Arrays;

public class FirstApp {
	public static void main(String[] args) {
		// 맛보기 자바 프로그램
		//System.out.println("Hello Java!");
		/*System.out.println(100+10);
		System.out.println(100*10);
		System.out.println(100-10);*/
		System.out.println(100/10); // 몫
		System.out.println(100%10); // 나머지
		System.out.println(Arrays.toString(new int[] {15,20,30}));
		int[] a = new int[] {15,5,30};
		Arrays.sort(a);
		System.out.println(Arrays.toString(a)); 
	}
}
