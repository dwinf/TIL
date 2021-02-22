package day9;
import day6.MethodLab3;

class Multiplication {
	private int dan;
	private int number;

	Multiplication() {
	}
	Multiplication(int dan) {
		this.dan = dan;
	}
	Multiplication(int dan, int number) {
		this.dan = dan;
		this.number = number;
	}
	public void printPart() {
		if (number == 0) {
			for (int n = 1; n <= 9; n++)
				System.out.print("\t" + dan + "*" + n + "=" + dan * n);
			System.out.println();
		} else {
			System.out.println(dan * number);
		}
	}
}

class GuGuDanExpr extends Multiplication {
	GuGuDanExpr(){
		
	}
	GuGuDanExpr(int dan){
		super(dan);
	}
	GuGuDanExpr(int dan, int number){
		super(dan,number);
	}
	static void printAll() {
		day3.ForTest8.main(null);
		/*for(int dan=1;dan<=9;dan++) {
			for(int num=1;num<=9;num++) {
				System.out.printf("%d*%d=%d\t", dan,num,dan*num);
			}
			System.out.println();
		}*/
	}
}
public class GuGuDan {

	public static void main(String[] args) {
		int dan = MethodLab3.getRandom(20);
		int number = MethodLab3.getRandom(20);
		GuGuDanExpr gugu;
		
		if((dan>=1&&dan<=9)&&(number>=1&&number<=9)) {
			gugu = new GuGuDanExpr(dan,number);
			System.out.print(dan + " * " + number + " = ");
			gugu.printPart();
		}
		else if((dan>=1&&dan<=9)&&number>=10) {
			gugu = new GuGuDanExpr(dan);
			System.out.print(dan + "´Ü : ");
			gugu.printPart();
		}
		else if(dan>=10) {
			GuGuDanExpr.printAll();
		}

	}

}
