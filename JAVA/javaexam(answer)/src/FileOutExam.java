import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class FileOutExam {
	public static void main(String[] args) {
		

		try (FileWriter  writer = new FileWriter("c:/iotest/today.txt")){     
			GregorianCalendar cal1 = new GregorianCalendar(1997,3,21);
			int year = cal1.get(GregorianCalendar.YEAR);
			int month = cal1.get(GregorianCalendar.MONTH);
			int day = cal1.get(GregorianCalendar.DAY_OF_MONTH); 
			int date = cal1.get(GregorianCalendar.DAY_OF_WEEK_IN_MONTH);
			
//            char arr[] = {'객','체','지','향','언','어'};          
//            for (int cnt = 0; cnt < arr.length; cnt++)
//                writer.write(arr[cnt]);
            writer.write("오늘은 ");
            writer.write(65);
            writer.write("년 ");
            writer.write(month);
            writer.write("월");
            writer.write(day);
            writer.write("일입니다.");
            writer.write('\n');
            writer.write("오늘은 ");
            writer.write(date);
            writer.write("입니다. ");
            System.out.println("저장이 완료되었습니다.");
        } 
		catch (IOException ioe) {
            System.out.println("파일에 저장하는 동안 오류가 발생했습니다.");
		}
	}
}
