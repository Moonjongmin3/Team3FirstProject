package Common;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

public class BookCookieManager {
	
	public static Object findCookie(HttpServletRequest request, String cookieName) {
		if(request.getCookies() == null) {
			return null;
		}
		return Arrays.stream(request.getCookies())
				.filter(cookie -> cookie.getName().equals(cookieName))
				.findAny()
				.orElse(null);
	}
}
