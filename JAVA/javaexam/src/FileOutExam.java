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
			
//            char arr[] = {'��','ü','��','��','��','��'};          
//            for (int cnt = 0; cnt < arr.length; cnt++)
//                writer.write(arr[cnt]);
            writer.write("������ ");
            writer.write(65);
            writer.write("�� ");
            writer.write(month);
            writer.write("��");
            writer.write(day);
            writer.write("���Դϴ�.");
            writer.write('\n');
            writer.write("������ ");
            writer.write(date);
            writer.write("�Դϴ�. ");
            System.out.println("������ �Ϸ�Ǿ����ϴ�.");
        } 
		catch (IOException ioe) {
            System.out.println("���Ͽ� �����ϴ� ���� ������ �߻��߽��ϴ�.");
		}
	}
}
