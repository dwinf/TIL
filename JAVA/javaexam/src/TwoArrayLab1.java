public class TwoArrayLab1 {

	public static void main(String[] args) {
		int[][] nums = new int[4][4];
		int first = 10;
		
		for(int i =0; i<nums.length;i++) {
			for(int j = 0; j<nums[i].length ; j++) {
				nums[i][j]=first;						///중요
				first = first + 2;
			}
		}
		System.out.println("1행 1열의 데이터 : "+nums[0][0]);
		System.out.println("3행 4열의 데이터 : "+nums[2][3]);
		System.out.println("행의 갯수 : "+nums.length);
		System.out.println("열의 갯수 : "+nums[0].length);
		System.out.print("3행의 데이터들 : ");
		for(int i =0; i<nums.length;i++) {
		System.out.print(nums[2][i]+" ");
		}
		System.out.println();
		System.out.print("2열의 데이터들 : ");
		for(int i =0; i<nums.length;i++) {
			System.out.print(nums[i][1]+" ");
		}
		System.out.println();
		System.out.print("왼쪽 대각선 데이터들 : ");
		for(int i=0;i<nums.length;i++) {
			for(int j=0;j<nums[i].length;j++) {
				if(i==j)
				System.out.print(nums[i][j]+" ");
			}
		}
		System.out.println();
//		System.out.print("오른쪽 대각선 데이터들 : ");
//		for(int i=nums.length-1;i>=0;i--) {
//			for(int j=0;j<nums[i].length;j++) {
//				if(i+j==(nums.length-1))
//				System.out.print(nums[i][j]+" ");
		System.out.print("오른쪽 대각선 데이터들 : ");
		for(int j=0;j<nums.length;j++) {
			for(int i=nums[j].length-1;i>=0;i--) {
		if(i+j==(nums.length-1))
	System.out.print(nums[j][i]+" ");
			}
		}
	}

}
