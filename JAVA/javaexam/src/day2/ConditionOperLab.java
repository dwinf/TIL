package day2;
public class ConditionOperLab {
	public static void main(String[] args) {
		int su = (int)(Math.random()*5)+1;
		int data1, data2,result;
		data1=300;
		data2=50;		
		if(su==1) 
			result = data1+data2;
		else if(su==2)
			result = data1-data2;
		else if(su==3)
			result = data1*data2;
		else if(su==4)
			result = data1/data2;
		else 
			result = data1%data2;
		
		System.out.println("°á°ú°ª : "+result);
	}
}
