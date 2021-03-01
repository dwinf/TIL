package day13;

import java.util.Scanner;
import java.util.HashMap;
import java.util.Iterator;

public class HashMapLab1 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
				
		int input_len = 5;
		String key; int value;
		while(hmap.size() < input_len) {		
			System.out.print("나라이름을 입력하세요 : ");
			key = sc.nextLine();
			
			System.out.print("인구 수를 입력하세요 : ");
			value = sc.nextInt();
			
			if(!hmap.containsKey(key)) {
				hmap.put(key, value);
				System.out.println("저장되었습니다.");
			}
			else {
				System.out.println("나라명 "+key+"는(은) 이미 저장되었습니다.");
			}
			sc.nextLine();
		}
		
		System.out.println();
		System.out.println("5개가 모두 입력되었습니다.");
		System.out.print("입력된 데이터 : ");
		
		Iterator<String>  it = hmap.keySet().iterator();
		
		while(true) {
			key = it.next();
			value = hmap.get(key);
			System.out.printf("%s(%d)", key, value);
			if(it.hasNext()) System.out.print(", ");
			else break;
		}
		sc.close();
	}
}
