package day13;
import java.util.*;
public class HashtableExample1 {
    public static void main(String args[]) {
        Hashtable<String, Integer> hashtable = 
        		new Hashtable<String, Integer>();
        hashtable.put("해리", new Integer(95));
        hashtable.put("헤르미온느", new Integer(100));
        hashtable.put("론", new Integer(85));
        hashtable.put("드레이코", new Integer(93));
        hashtable.put("네빌", new Integer(70));
        hashtable.put("헤르미온느", 55); // JDK 1.5 Auto Boxing 구문
        System.out.println(hashtable);
        Integer num = hashtable.get("헤르미온느");
        System.out.println("헤르미온느의 성적은? " + num);
    }
}
