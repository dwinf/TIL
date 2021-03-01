package collection;
public class Product2 {
	private String productID;
	private String productName;
	private String productPrice;
	public Product2(String productID, String productName, String productPrice) {
		super();
		this.productID = productID;
		this.productName = productName;
		this.productPrice = productPrice;
	}
	@Override
	public String toString() {
		return "Product2 [productID=" + productID + ", productName=" + productName + ", productPrice=" + productPrice
				+ "]";
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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((productID == null) ? 0 : productID.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Product2 other = (Product2) obj;
		if (productID == null) {
			if (other.productID != null)
				return false;
		} else if (!productID.equals(other.productID))
			return false;
		return true;
	}

	

}
