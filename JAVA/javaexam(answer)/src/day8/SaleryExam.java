package day8;
import day6.MethodLab3;
class SalaryExpr {
	int bonus;
	
	SalaryExpr() {
		this(0);
	}
	SalaryExpr(int bonus) {
		this.bonus = bonus;
	}
	
	int getSalary(int grade) {
		int n = 0;
		switch(grade) {
			case 1 : 
				n = bonus + 100;
				break;
			case 2 : 
				n = bonus + 90;
				break;
			case 3 : 
				n = bonus + 80;
				break;
			default :
				n = bonus + 70;
		}
		return n;
	}
}

public class SaleryExam {

	public static void main(String[] args) {
		int month = MethodLab3.getRandom(12);    //왜 자꾸 중복이 뜨는지?
		int grade = MethodLab3.getRandom(4);
		
		if(month%2==0) {             //또또 중괄호때문에 오류나서 고생함
			SalaryExpr money = new SalaryExpr(100);
			System.out.printf("%d월 %d등급의 월급은 %d만원 입니다.", month,grade,money.getSalary(grade));
		}else {
			SalaryExpr money = new SalaryExpr();
			System.out.printf("%d월 %d등급의 월급은 %d만원 입니다.", month,grade,money.getSalary(grade));
		}	
	}
}
