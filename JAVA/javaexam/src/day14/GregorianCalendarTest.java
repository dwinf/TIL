package day14;
import java.util.*;
public class GregorianCalendarTest {
	public static void main(String[] args) {
		GregorianCalendar gc = new GregorianCalendar();
		System.out.println(gc.get(Calendar.DAY_OF_YEAR));
		System.out.println(gc.get(Calendar.YEAR));
		System.out.println(gc.get(Calendar.MONTH));
		System.out.println(gc.get(Calendar.DAY_OF_MONTH));
		System.out.println(gc.get(Calendar.DATE));
		System.out.println(gc.get(Calendar.DAY_OF_WEEK_IN_MONTH));
		System.out.println(gc.get(Calendar.DAY_OF_WEEK));
		
		System.out.printf("%tY\n", gc);
		System.out.printf("%ty\n", gc);
		System.out.printf("%tm\n", gc);
		System.out.printf("%tb\n", gc);
		System.out.printf("%tH\n", gc);
		System.out.printf("%tM\n", gc);
		System.out.printf("%tS\n", gc);
		System.out.printf("%tA\n", gc);
		System.out.printf("%ta\n", gc);
	}
}
