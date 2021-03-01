package day7;

class StudentNew2 {
	String name;
	int age;
	String subject;
	StudentNew2() {
		
	}
	StudentNew2(String p1, int p2){
		name = p1;
		age = p2;
		subject = "자바";		
	}
	StudentNew2(String p1, int p2, String p3){
		name = p1;
		age = p2;
		subject = p3;		
	}
	void printStudentInfo() {
		System.out.println(name+"학생은 나이가 "+age+"입니다.");
	}
	void study() {
		System.out.println(name+"학생은 "+subject+"과목을 학습합니다.");
	}
	void study(int hour) {
		System.out.println(name+"학생은 "+subject+"과목을 " + hour +"동안 학습합니다.");
	}
}
public class StudentTest3 {
	public static void main(String[] args) {
		StudentNew2 st1 = new StudentNew2("듀크", 24, "JavaScript");
		System.out.println(st1);
		st1.study(2);
		StudentNew2 st2 = new StudentNew2("둘리", 100);
		System.out.println(st2);
		st2.study(2);
		StudentNew2 st3 = new StudentNew2();
		System.out.println(st3);
		st3.study(2);
	}
}








