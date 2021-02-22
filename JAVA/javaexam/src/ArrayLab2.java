public class ArrayLab2 {

	public static void main(String[] args) {
		
		int ary1[] = new int [10];
		ary1[0] = (int) (Math.random()*17) + 4;
		ary1[1] = (int) (Math.random()*17) + 4;
		ary1[2] = (int) (Math.random()*17) + 4;
		ary1[3] = (int) (Math.random()*17) + 4;
		ary1[4] = (int) (Math.random()*17) + 4;
		ary1[5] = (int) (Math.random()*17) + 4;
		ary1[6] = (int) (Math.random()*17) + 4;
		ary1[7] = (int) (Math.random()*17) + 4;
		ary1[8] = (int) (Math.random()*17) + 4;
		ary1[9] = (int) (Math.random()*17) + 4;
		
		System.out.println("모든 원소의 값 :" + ary1[0]+", "+ary1[1]+", "+ary1[2]+", "+ary1[3]+", "
		           +ary1[4]+", "+ary1[5]+", "+ary1[6]+", "+ary1[7]+", "+ary1[8]+", "+ary1[9]);
		System.out.println("모든 원소의 합 :" + (ary1[0]+ary1[1]+ary1[2]+ary1[3]
				           +ary1[4]+ary1[5]+ary1[6]+ary1[7]+ary1[8]+ary1[9]));

	}

}
