package day14;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class FileOutExam {
	public static void main(String[] args) {
		String path = "C:/iotest/";
		String filename = "today.txt";
		File isDir = new File(path);
        if (!isDir.exists()) {
        	isDir.mkdirs();
        }
        
        try(FileWriter writer = new FileWriter(path + filename);){
        	Calendar c = Calendar.getInstance();
        	       	
        	writer.write(String.format("오늘은 %tY년 %tm월 %td일입니다.\n", c, c, c));
        	writer.write(String.format("오늘은 %ta요일입니다.\n", c));
        	
        	c = new GregorianCalendar(2019, 12, 20);
        	writer.write(String.format("저는 %ta요일에 태어났습니다.\n", c));
        	
        	System.out.println("저장이 완료되었습니다.");
        	
        }catch(IOException e) {
        	System.out.println(e.getMessage());
        	System.out.println("파일에 저장하는 동안 오류가 발생했습니다.");
        }
	        
	}
}
