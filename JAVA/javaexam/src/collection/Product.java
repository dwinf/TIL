package collection;

public class Product {

	private String productID;
	private String productName;
	private String productPrice;
	
	Product(){}

	Product(String productID, String productName, String productPrice)
	{
		this.productID = productID;
		this.productName = productName;
		this.productPrice = productPrice;
	}
	public String getProductID() {
		return productID;
	}

	public void setProductID(String productID) {
		this.productID = productID;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	@Override
	public int hashCode()
	{
		return productID.hashCode();	
	}
	
	public String toString()
	{
		return String.format("%-10s\t%-10s\t%-10s", productID, productName, productPrice);
	}
	
	public boolean equals(Object o)
	{
		boolean result=false;
		
		if(o != null && o instanceof Product)
		{
			Product p = (Product)o;
			if(productID.equals(p.productID))
			{
				result = true;
			}
		}
		return result;
	}

}
