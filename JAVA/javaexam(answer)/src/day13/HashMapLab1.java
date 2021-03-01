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
			System.out.print("�����̸��� �Է��ϼ��� : ");
			key = sc.nextLine();
			
			System.out.print("�α� ���� �Է��ϼ��� : ");
			value = sc.nextInt();
			
			if(!hmap.containsKey(key)) {
				hmap.put(key, value);
				System.out.println("����Ǿ����ϴ�.");
			}
			else {
				System.out.println("����� "+key+"��(��) �̹� ����Ǿ����ϴ�.");
			}
			sc.nextLine();
		}
		
		System.out.println();
		System.out.println("5���� ��� �ԷµǾ����ϴ�.");
		System.out.print("�Էµ� ������ : ");
		
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
