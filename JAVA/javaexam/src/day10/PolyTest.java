package day10;

public class PolyTest {
	public static void main(String[] args) {
		printObjectInfo(new Object());
		printObjectInfo(new String("가나다"));
		printObjectInfo("ABC");
		printObjectInfo(new java.util.Date());
		printObjectInfo(new java.io.File("c:/unico/eclipse-workspace/javaexam"));
		printObjectInfo(new int[10]);
		printObjectInfo(new double[5]);
		printObjectInfo(new day7.Member());
		printObjectInfo(new Integer(100));
		printObjectInfo(100); // Java 5 부터 AutoBoxing 구문
		printObjectInfo('가'); 
	}
	static void printObjectInfo(Object o) {
		if(o instanceof String) {
			System.out.println("문자열 객체 전달됨 : "+
					o.getClass().getName() + " - " + ((String)o).length());
		} else {
			System.out.println("전달된 객체의 클래스명 : "+
										o.getClass().getName());
		}		
	}
}





