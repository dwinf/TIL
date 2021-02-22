package day15;

import java.net.*;
import java.io.*;
public class URLTest4 {
	public static void main(String[] args) {
		InputStream is = null;
		BufferedReader reader = null;
		BufferedWriter fw = null;
		try {
			URL req = new URL("http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1168064000");
			is = req.openStream();
			reader = new BufferedReader(
					                       new InputStreamReader(is, "utf-8"));
			fw = new BufferedWriter(new OutputStreamWriter(
					     new FileOutputStream("c:/iotest/weather.xml"), "utf-8"));
			String lineStr = "";
			while(true) {
				lineStr = reader.readLine();
				if(lineStr == null)
					break;
				fw.write(lineStr+"\r\n");				
			}	
			System.out.println("weather.xml이 성공적으로 생성되었습니다.");
		} catch (MalformedURLException e) {
			System.out.println("URL문자열 오류 : "+e.getMessage());
		} catch (IOException e) {
			System.out.println("IO 오류 : "+e.getMessage());
		}  finally {
			try {
				if (fw != null) 
					fw.close();
				if (reader != null) 
					reader.close();
				if (is != null) 
					is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}			
		}
	}
}



