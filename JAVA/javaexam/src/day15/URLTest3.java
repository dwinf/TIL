package day15;

import java.net.*;
import java.io.*;
public class URLTest3 {
	public static void main(String[] args) {
		try {
			URL req = new URL("http://img.etnews.com/news_ebuzz/afieldfile/2012/01/04/c_bk010101_87984_3.jpg");
			InputStream is = req.openStream();
			FileOutputStream fos = new FileOutputStream("c:/iotest/duke.jpg");
			int input=0;
			while(true) {
				input = is.read();
				if(input == -1)
					break;
				fos.write(input);				
			}
			fos.close();
			System.out.println("duke.jpg가 성공적으로 생성되었습니다.");
		} catch (MalformedURLException e) {
			System.out.println("URL문자열 오류 : "+e.getMessage());
		} catch (IOException e) {
			System.out.println("IO 오류 : "+e.getMessage());
		} 
	}
}
