public class ArrayLab3 {

	public static void main(String[] args) {

		char ary3[] = new char[] { 'J', 'a', 'v', 'a' };

		for (int i = 0; i < ary3.length; i++) {
			if (i == ary3.length - 1) {
				if (ary3[i] <= 96) {
					System.out.print((char) (ary3[i] + 32));
				} else {
					System.out.print((char) (ary3[i] - 32));
				}

			} else {
				if (ary3[i] <= 96) {
					System.out.print("변환된 배열 : "+(char) (ary3[i] + 32) + ", ");
				} else {
					System.out.print((char) (ary3[i] - 32) +", ");
				}

			}
		}
	}
}
