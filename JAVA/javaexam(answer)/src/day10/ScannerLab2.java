package day10;

import java.util.Scanner;

public class ScannerLab2 {	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int num1, num2;
		int result = 0;
		boolean flag = false;
		String ss;
		// 숫자와 연산자를 입력받아 처리하는 기능을 3번 반복하도록 코드 추가
		for (int i = 1; i < 4; i++) {
			System.out.print("첫 번째 숫자를 입력하세요 : ");
			num1 = sc.nextInt();
			System.out.print("두 번째 숫자를 입력하세요 : ");
			num2 = sc.nextInt();
			System.out.print("연산자(+, -, *, /)를 입력하세요 : ");
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
				System.out.println("+, -, *, / 를 입력하숑");
			} else {
				System.out.println(num1 + "와 " + num2 + "의 " + ss + " 연산 결과는 " + result + "입니다.");
			}
		}
		sc.close();
	}
}
