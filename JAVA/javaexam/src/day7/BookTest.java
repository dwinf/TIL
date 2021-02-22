package day7;

class Book{
	
	String title;
	String author;
	int price;
	
	Book(){		
		this("자바의 정석", "남궁 성", 30000);
	}
	Book(String title, String author, int price){
		this.title = title;
		this.author = author;
		this.price = price;
	}	
	String getbookinfo() {
		return "책 이름 : " + title+" 책 저자: "+ author + "가격 : "+ price;		
				
	}
}
public class BookTest {

	public static void main(String[] args) {
		Book book1 = new Book();
		Book book2 = new Book("수학의 정석", "홍XX", 15000);
		Book book3 = new Book("과학의 정석", "김XX", 23000);
		Book book4 = new Book("사회의 정석", "박XX", 53000);
		Book book5 = new Book("영어의 정석", "이XX", 56000);		

		System.out.println(book1.getbookinfo());
		System.out.println(book2.getbookinfo());
		System.out.println(book3.getbookinfo());
		System.out.println(book4.getbookinfo());
		System.out.println(book5.getbookinfo());
	}

}
