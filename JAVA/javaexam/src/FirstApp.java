import java.util.Arrays;

public class FirstApp {
	public static void main(String[] args) {
		// ������ �ڹ� ���α׷�
		//System.out.println("Hello Java!");
		/*System.out.println(100+10);
		System.out.println(100*10);
		System.out.println(100-10);*/
		System.out.println(100/10); // ��
		System.out.println(100%10); // ������
		System.out.println(Arrays.toString(new int[] {15,20,30}));
		int[] a = new int[] {15,5,30};
		Arrays.sort(a);
		System.out.println(Arrays.toString(a)); 
	}
}
