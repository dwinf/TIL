package day15;

import java.net.*;
import java.io.*;
public class URLTest2 {
	public static void main(String[] args) {
		try {
			URL req = new URL("http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1168064000");
			InputStream is = req.openStream();
			BufferedReader reader = new BufferedReader(
					                       new InputStreamReader(is, "UTF-8"));
			String lineStr = "";
			while(true) {
				lineStr = reader.readLine();
				if(lineStr == null)
					break;
				System.out.println(lineStr);				
			}			
		} catch (MalformedURLException e) {
			System.out.println("URL문자열 오류 : "+e.getMessage());
		} catch (IOException e) {
			System.out.println("IO 오류 : "+e.getMessage());
		}
	}
}
