package day14;
import java.io.*;
public class FileReaderTest2 {
    public static void main(String args[]) {
       FileReader reader = null;
       BufferedReader br = null;
       try {
           reader = new FileReader("c:/iotest/output.txt");
           br = new BufferedReader(reader);
           while (true) {
               String data = br.readLine();
               if (data == null)
                   break;               
               System.out.println(data);
           }
       } catch (FileNotFoundException fnfe) {
           System.out.println("파일이 존재하지 않습니다.");
       } catch (IOException ioe) {
           System.out.println("파일을 읽을 수 없습니다.");
       } finally {
          try {
        	   br.close();
               reader.close();
          } catch (Exception e) {
        	  e.printStackTrace();
          }
       }
    }
}
