package day15;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CopyExam {
	public static String timeToStrDate(long time) {
		DateFormat formatter = 
				new SimpleDateFormat("yyyy_MM_dd");
		return formatter.format(time);
	}
	public static void main(String[] args) {
		String time = timeToStrDate(new Date().getTime());
		try(FileReader reader = new FileReader("c:/iotest/sample.txt");
			BufferedReader br = new BufferedReader(reader);	
			FileWriter fw = new FileWriter(String.format("c:/iotest/%s_%s.txt", "sample", time),true);){
			
			while(true)
			{
				String data = br.readLine();
				if(data == null) break;
				fw.write(data+'\n');
			}

			System.out.println("���� �Ϸ�Ǿ����ϴ�.");
		}catch(Exception e){
			System.out.println("ó���ϴ� ���� ������ �߻��߽��ϴ�" + e.getMessage());
		}

	}

}
