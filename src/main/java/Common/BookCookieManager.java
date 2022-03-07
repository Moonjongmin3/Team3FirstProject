package Common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.Cookie;
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
	public static boolean isSameCookie(HttpServletRequest request, String cookieName, String bookId) {
		Cookie[] cookies = request.getCookies();
		String history = "";
		for (Cookie cookie : cookies) {
			if(cookie.getName().equals(cookieName)) history = cookie.getValue(); 
		}
		List<String> books = Arrays.asList(history.split("x"));
		
		return books.contains(bookId);
	}
}
