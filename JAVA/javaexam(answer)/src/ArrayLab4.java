public class ArrayLab4 {

	public static void main(String[] args) {

		int[] ary4 = new int[10];
		for (int i = 0; i < ary4.length; i++)
			ary4[i] = (int) (Math.random() * 26) + 1;

		for (int i = 0; i < ary4.length; i++)
			System.out.print(ary4[i] + ", ");

		System.out.println();

		char ary5[] = new char[10];
		int i = 0;

		for (i = 0; i < ary5.length; i++) {
			ary5[i] = (char) (ary4[i] + 64);

			if (i == ary5.length - 1)
				System.out.print((char) ary5[i]);
			else
				System.out.print((char) ary5[i] + ",");
		}
	}
}
