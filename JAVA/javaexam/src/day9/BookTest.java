package day9;

class Book{	
	String title;
	String author;
	private int price;
	
	Book(){		
		this("�ڹ��� ����", "���� ��", 30000);
	}
	Book(String title, String author, int price){
		this.title = title;
		this.author = author;
		setPrice(price);
	}	
	void setPrice(int price) {
		if (price < 0)
			this.price = -price;
		else
			this.price = price;
	}
	String getbookinfo() {
		return "å �̸� : " + title+" å ����: "+ author + "���� : "+ price;		
				
	}
}
public class BookTest {

	public static void main(String[] args) {
		Book book = new Book("�ڹ�������", "���ü�", -30000);	
		book.setPrice(-33000);

		System.out.println(book.getbookinfo());
		
	}

}






