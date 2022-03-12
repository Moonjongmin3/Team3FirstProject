package Common;

import vo.OrderHistoryVO;
import vo.PayVO;

public class InstanceConverter {
	public OrderHistoryVO converToOHVO(PayVO payInfo, String userId) {
		   OrderHistoryVO order = new OrderHistoryVO();
		   
		   order.setOrder_id(payInfo.getMerchantUid());
		   order.setUser_id(userId);
		   order.setReceiver_name(payInfo.getBuyerName());
		   
		   String[] addressArr = payInfo.getBuyerAddr().split("/");
		   order.setShip_address1(addressArr[0]);
		   order.setShip_address2(addressArr[1]);
		   
		   order.setZipcode(payInfo.getBuyerPostcode());
		   order.setReceiver_phone(Integer.parseInt(payInfo.getBuyerTel().replaceAll("-", "")));
		   order.setState("결제완료");
		   order.setPay_state(1);
		   order.setTotal_price(payInfo.getAmount());
		   
		   return order;
	   }
}
