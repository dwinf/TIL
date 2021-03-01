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
		int month = MethodLab3.getRandom(12);    //�� �ڲ� �ߺ��� �ߴ���?
		int grade = MethodLab3.getRandom(4);
		
		if(month%2==0) {             //�Ƕ� �߰�ȣ������ �������� �����
			SalaryExpr money = new SalaryExpr(100);
			System.out.printf("%d�� %d����� ������ %d���� �Դϴ�.", month,grade,money.getSalary(grade));
		}else {
			SalaryExpr money = new SalaryExpr();
			System.out.printf("%d�� %d����� ������ %d���� �Դϴ�.", month,grade,money.getSalary(grade));
		}	
	}
}
