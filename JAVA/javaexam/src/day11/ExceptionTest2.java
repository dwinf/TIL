package day11;
public class ExceptionTest2 {
	public static void main(String[] args){
		System.out.println("�������");
		try {
			int num1 = Integer.parseInt(args[0]);
			int num2 = Integer.parseInt(args[1]);
			int result = num1/num2;
			System.out.println("���� ��� : "+result);
		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("���α׷� �ƱԸ�Ʈ�� 2 �� �����ϼ���!!");
		} catch (ArithmeticException e) {
			e.printStackTrace();
			System.out.println("�ι�° ���α׷� �ƱԸ�Ʈ�� 0�� �ƴ� ���� �����ϼ���!!");
			return;
		} catch (NumberFormatException e) {
			e.printStackTrace();
			System.out.println("���α׷� �ƱԸ�Ʈ�� ���ڸ� �����ϼ���!!");
		} finally {
			System.out.println("�׻� ����!!");
		}
		System.out.println("��������");
	}
}
