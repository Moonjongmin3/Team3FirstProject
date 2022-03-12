package vo;

public class OrderItemVO {
	private long orderId;
	private int bookId;
	private int quantity;
	
	public OrderItemVO() {}
	public OrderItemVO(long orderId, int bookId, int quantity) {
		this.orderId = orderId;
		this.bookId = bookId;
		this.quantity = quantity;
	}

	public long getOrderId() {
		return orderId;
	}
	public void setOrderId(long orderId) {
		this.orderId = orderId;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	

}
