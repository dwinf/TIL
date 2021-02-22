package day2;
public class OperTest2 {
	public static void main(String[] args) {
		// 증감연산자 : 증가연산자(++), 감소연산자(--)
		int su1, su2, su3, su4;
		su1 = 10;
		System.out.println(su1);		//10
		System.out.println(++su1);	//11
		System.out.println(++su1);	//12
		System.out.println(++su1);	//13
		System.out.println(--su1);	//12
		
		su2 = 10;
		System.out.println(su2);		//10
		System.out.println(su2++);	//10
		System.out.println(su2++);	//11
		System.out.println(su2++);	//12
		System.out.println(su2--);	//13
		System.out.println(su2);		//12
		
		su3 = 10;
		System.out.println(su3);		//10
		System.out.println(su3++);	//10
		System.out.println(++su3);	//12
		System.out.println(su3++);	//12
		System.out.println(--su3);	//12
		System.out.println(--su3);	//11
		
		su4 = 10;
		System.out.println(su4);		//10
		++su4;
		System.out.println(su4);		//11
		su4++;
		System.out.println(su4);		//12
		//++10;
		//10 = 10 +1;
	}
}
