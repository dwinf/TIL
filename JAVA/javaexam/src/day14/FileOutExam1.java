package day14;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class FileOutExam1 {

	public static void main(String[] args) {
		char[] week = {'��', '��', 'ȭ', '��', '��', '��', '��'};
        String path = "C:/iotest";
        
        File isDir = new File(path);
        if (!isDir.exists()) {
        	isDir.mkdirs();
        }
		try (FileWriter writer = new FileWriter("c:/iotest/today1.txt", true);
        		PrintWriter out = new PrintWriter(writer)){         
			GregorianCalendar gc = new GregorianCalendar();
			out.printf("������ %d�� %d�� %d���Դϴ�.\r\n", gc.get(Calendar.YEAR),
					gc.get(Calendar.MONTH)+1, gc.get(Calendar.DATE));
			int day = gc.get(Calendar.DAY_OF_WEEK_IN_MONTH);
			out.printf("������ %s�����Դϴ�.\r\n", week[day-1]);
			gc.set(2019, 4, 11);//���� ����
			day = gc.get(Calendar.DAY_OF_WEEK_IN_MONTH);
			out.printf("XXX�� %s���Ͽ� �¾���ϴ�.%n", week[day-1]);
			System.out.print("������ �Ϸ�Ǿ����ϴ�.");
		} catch (IOException ioe) {
            System.out.println("���Ͽ� �����ϴ� ���� ������ �߻��߽��ϴ�.");
        } 
	}

}
