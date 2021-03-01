package collection;

import java.util.HashSet;

public class ProductTest {

	public static void main(String[] args) {
		Product[] p = new Product[4];
		
		p[0] = new Product("p100", "TV", "20000");
		p[1] = new Product("p200", "computer", "10000");
		p[2] = new Product("p100", "MP3", "700");
		p[3] = new Product("p300", "Audio", "1000");
		
		HashSet<Product> hs = new HashSet<Product>();
		
		for(int i = 0; i<4; i++)
		{
			if(hs.add(p[i]))
			{
				System.out.println(p[i].getProductID() + " 성공적으로 저장되었습니다.");
			}
			else
			{
				System.out.println(p[i].getProductID() + " 동일한 ID의 제품이 이미 저장되었습니다.");
			}
		}
		
		System.out.println();
		System.out.println(String.format("%-10s\t%-10s\t%-10s\t", "제품ID", "제품명", "가격"));
		System.out.println("==========================================");
		
		for(Product plist : hs)
		{
			System.out.println(plist.toString());
		}
	}

}
