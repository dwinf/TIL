package day7;

class Product {
	String name;
	int balance;
	int price;
	Product() {
		this("��ũ����", 5, 10000);
	}
	Product(String name, int balance, int price) {
		this.name = name;
		this.balance = balance;
		this.price = price;
	}
	public String getName() {   // getXxx()
		return name;
	}
	public int getBalance() {
		return balance;
	}
	public int getPrice() {
		return price;
	}
}

public class ProductTest {

	public static void main(String[] args) {

		Product[] p = new Product[5];
		p[0] = new Product("ġŲ����", 3, 9000);
		p[1] = new Product("��ġ���", 5, 15000);
		p[2] = new Product("���ô�", 6, 30000);
		p[3] = new Product("����", 7, 49000);
		p[4] = new Product("����", 16, 16000);
		
		System.out.println(p);
		for (int i = 0; i < p.length; i++) {
			System.out.printf("%10s\t\t%d\t%,d��\n", p[i].getName(),	
					p[i].getBalance(), p[i].getPrice());
		}
		for(Product data : p )
			System.out.printf("%10s\t\t%d\t%,d��\n", data.getName(),	
					data.getBalance(), data.getPrice());
		
	}
}




