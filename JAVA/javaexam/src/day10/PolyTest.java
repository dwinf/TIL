package day10;

public class PolyTest {
	public static void main(String[] args) {
		printObjectInfo(new Object());
		printObjectInfo(new String("������"));
		printObjectInfo("ABC");
		printObjectInfo(new java.util.Date());
		printObjectInfo(new java.io.File("c:/unico/eclipse-workspace/javaexam"));
		printObjectInfo(new int[10]);
		printObjectInfo(new double[5]);
		printObjectInfo(new day7.Member());
		printObjectInfo(new Integer(100));
		printObjectInfo(100); // Java 5 ���� AutoBoxing ����
		printObjectInfo('��'); 
	}
	static void printObjectInfo(Object o) {
		if(o instanceof String) {
			System.out.println("���ڿ� ��ü ���޵� : "+
					o.getClass().getName() + " - " + ((String)o).length());
		} else {
			System.out.println("���޵� ��ü�� Ŭ������ : "+
										o.getClass().getName());
		}		
	}
}





