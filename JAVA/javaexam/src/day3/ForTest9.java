package day3;
public class ForTest9 {
	public static void main(String[] args) {
		final char DECO = '@'; //���:�ʱ�ȭ�� ���� �����Ǵ� ����		
		//final double PI = 3.14;
		for(int rowNum=9; rowNum >= 1 ; rowNum--) {
			for(int colNum=1; colNum <= rowNum; colNum++)
				System.out.print(DECO);
			System.out.println();
		}		
	}
}