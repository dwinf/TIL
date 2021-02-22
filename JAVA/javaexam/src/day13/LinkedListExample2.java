package day13;
import java.util.*;
class LinkedListExample2 {
    public static void main(String args[]) {
        LinkedList<String> list = new LinkedList<String>();
        list.add("Æ÷µµ");            
        list.add("µþ±â");           
        list.add("º¹¼þ¾Æ");          
        list.add(2, "Å°À§");          
        list.set(0, "¿À·»Áö");         
        list.remove(1);             
        list.remove("Å°À§");        
        int num = list.size();
        for (int cnt = 0; cnt < num; cnt++) {
            String str = list.get(cnt);
            System.out.println(str);
        }
    }
}
