package vo;

import java.util.Date;

public class OrderHistoryVO {
		//출력용
	   private int order_id;//주문번호
	   private int book_id;//책id
	   private String user_id;//회원id
	   private String receiver_name;//받는분 성함
	   private String ship_address1;//주소
	   private String ship_address2;//상세주소
	   private String zipcode;//배송지 우편번호
	   private int receiver_phone;//받는분 번호
	   private String ship_request;//배송메세지
	   private String state;//주문상태(주문완료/취소 , 결제완료)
	   private int pay_state;//결제 여부(df 0)
	   private Date order_date;//주문일
	   private int total_price;//결제금액
	   private int quantity;
	   
	   private String poster;
	   private String cate_name;
	   //
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getBook_id() {
		return book_id;
	}
	public void setBook_id(int book_id) {
		this.book_id = book_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getShip_address1() {
		return ship_address1;
	}
	public void setShip_address1(String ship_address1) {
		this.ship_address1 = ship_address1;
	}
	public String getShip_address2() {
		return ship_address2;
	}
	public void setShip_address2(String ship_address2) {
		this.ship_address2 = ship_address2;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public int getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(int receiver_phone2) {
		this.receiver_phone = receiver_phone2;
	}
	public String getShip_request() {
		return ship_request;
	}
	public void setShip_request(String ship_request) {
		this.ship_request = ship_request;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getPay_state() {
		return pay_state;
	}
	public void setPay_state(int pay_state) {
		this.pay_state = pay_state;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}

	   
}
