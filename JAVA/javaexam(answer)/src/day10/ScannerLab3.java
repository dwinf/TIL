package day10;

import java.util.Scanner;

public class ScannerLab3 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int num1, num2;
		int result = 0;
		boolean flag = false;
		String ss;
		// 숫자와 연산자를 입력받아 처리하는 기능을 사용자가 
		// 원할 때까지 반복하도록 코드 추가
		// 결과 출력 사용자에게 계속수행하겠는지는지에 대한 메시지를 출력하고
		// 1을 입력하면 계속수행이고 다른 숫자를 입력하면 종료		
		while (true) {
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
			System.out.print("계속 수행하시겠습니까?(y 입력: 계속 수행, 다른 값 입력 : 종료) : ");
			if(!sc.next().equals("y"))
				break;
		}
		sc.close();
	}
}







