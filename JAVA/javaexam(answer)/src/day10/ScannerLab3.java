package day10;

import java.util.Scanner;

public class ScannerLab3 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int num1, num2;
		int result = 0;
		boolean flag = false;
		String ss;
		// ���ڿ� �����ڸ� �Է¹޾� ó���ϴ� ����� ����ڰ� 
		// ���� ������ �ݺ��ϵ��� �ڵ� �߰�
		// ��� ��� ����ڿ��� ��Ӽ����ϰڴ��������� ���� �޽����� ����ϰ�
		// 1�� �Է��ϸ� ��Ӽ����̰� �ٸ� ���ڸ� �Է��ϸ� ����		
		while (true) {
			System.out.print("ù ��° ���ڸ� �Է��ϼ��� : ");
			num1 = sc.nextInt();
			System.out.print("�� ��° ���ڸ� �Է��ϼ��� : ");
			num2 = sc.nextInt();
			System.out.print("������(+, -, *, /)�� �Է��ϼ��� : ");
			ss = sc.next();
						
			switch (ss) {
			case "+":
				result = num1 + num2;
				break;
			case "-":
				result = num1 - num2;
				break;
			case "/":
				result = num1 / num2;
				break;
			case "*":
				result = num1 * num2;
				break;
			default:
				flag = true;
			}

			if (flag == true) {
				System.out.println("+, -, *, / �� �Է��ϼ�");
			} else {
				System.out.println(num1 + "�� " + num2 + "�� " + ss + " ���� ����� " + result + "�Դϴ�.");
			}
			System.out.print("��� �����Ͻðڽ��ϱ�?(y �Է�: ��� ����, �ٸ� �� �Է� : ����) : ");
			if(!sc.next().equals("y"))
				break;
		}
		sc.close();
	}
}







