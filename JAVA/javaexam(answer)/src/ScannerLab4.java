import java.util.Scanner;

public class ScannerLab4 {

	public static void main(String[] args) {
		
		int num1 = 0;
		int num2 = 0;
		String oper = "";
		int sum = 0;
		boolean flag = true;
		String loop = "";
		// 숫자와 연산자를 입력받아 처리하는 기능을
		// 사용자가 원할 때까지 반복하도록 코드 추가
		// 결과 출력 후 사용자에게 계속 수행하겠는지에 대한 메시지를 출력하고
		// 1을 입력하면 계속 수행이고 2를 입력하면 종료
		
		
		while(flag)
		{			
			Scanner sc = new Scanner(System.in);
			System.out.println(sc.hashCode());
			sc.nextLine();
			System.out.print("첫 번째 숫자를 입력하세요 :");
			num1 = sc.nextInt();
			System.out.print("두 번째 숫자를 입력하세요 :");
			num2 = sc.nextInt();
			System.out.print("연산자(+, -, *, /)를 입력하세요 :");
			oper = sc.next();
			
			switch(oper){
			case "+":
				sum = num1 + num2;
				System.out.printf("%d와 %d의 연산 결과는 %d입니다.\n", num1, num2, sum);
				break;
			case "-":
				sum = num1 - num2;
				System.out.printf("%d와 %d의 연산 결과는 %d입니다.\n", num1, num2, sum);
				break;
			case "/":
				sum = num1 / num2;
				System.out.printf("%d와 %d의 연산 결과는 %d입니다.\n", num1, num2, sum);
				break;
			case "*":
				sum = num1 * num2;
				System.out.printf("%d와 %d의 연산 결과는 %d입니다.\n", num1, num2, sum);
				break;
			default:
				System.out.println("+, -, *, / 를 입력하숑");
			}	
			
			//System.out.print("계속 수행하시겠습니까?(1: 계속 수행) : ");
			System.out.print("계속 수행하시겠습니까?(y : 계속 수행):");
			loop = sc.next();
			if(!loop.equals("y"))
			{
				flag = false; 
			}
			//if(loop != 1)
			//{
			//	flag = false; 
			//}
			sc.nextLine();
			sc.close();
			//sc = null;
			//System.out.println(sc.hashCode());
			
			//sc = null;
		}

	}

}
