package day14;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class FileOutExam1 {

	public static void main(String[] args) {
		char[] week = {'일', '월', '화', '수', '목', '금', '토'};
        String path = "C:/iotest";
        
        File isDir = new File(path);
        if (!isDir.exists()) {
        	isDir.mkdirs();
        }
		try (FileWriter writer = new FileWriter("c:/iotest/today1.txt", true);
        		PrintWriter out = new PrintWriter(writer)){         
			GregorianCalendar gc = new GregorianCalendar();
			out.printf("오늘은 %d년 %d월 %d일입니다.\r\n", gc.get(Calendar.YEAR),
					gc.get(Calendar.MONTH)+1, gc.get(Calendar.DATE));
			int day = gc.get(Calendar.DAY_OF_WEEK_IN_MONTH);
			out.printf("오늘은 %s요일입니다.\r\n", week[day-1]);
			gc.set(2019, 4, 11);//생일 설정
			day = gc.get(Calendar.DAY_OF_WEEK_IN_MONTH);
			out.printf("XXX는 %s요일에 태어났습니다.%n", week[day-1]);
			System.out.print("저장이 완료되었습니다.");
		} catch (IOException ioe) {
            System.out.println("파일에 저장하는 동안 오류가 발생했습니다.");
        } 
	}

}
