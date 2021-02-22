package day14;
import java.util.*;
class HashMapExample2 {
    public static void main(String args[]) {
        HashMap<Name, Integer> hm = 
                                new HashMap<Name, Integer>();
        hm.put(new Name("해리", "포터"), new Integer(95));
        hm.put(new Name("헤르미온느", "그레인져"), new Integer(100));
        hm.put(new Name("론", "위즐리"), new Integer(85));
        hm.put(new Name("드레이코", "말포이"), new Integer(93));
        hm.put(new Name("네빌", "롱버텀"), new Integer(70));
        hm.put(new Name("헤르미온느", "그레인져"), new Integer(55));
        System.out.println(hm);
    }
}
