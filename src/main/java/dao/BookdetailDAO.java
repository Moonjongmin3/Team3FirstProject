package dao;
import vo.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import Common.*;

public class BookdetailDAO {
	private Connection con;
    private PreparedStatement psmt;
    ConnectionManager cm = new ConnectionManager();
    
    public BookVO BookdetailData(int id) {
    	BookVO book= new BookVO();
    	try
    	{
    		con = cm.getConnection();
    		String sql="SELECT * FROM BOOKS_3 WHERE id=?";
    		psmt=con.prepareStatement(sql);
    		psmt.setInt(1, id);
    		ResultSet rs=psmt.executeQuery();
    		rs.next();

    		book.setPoster(rs.getString("poster"));
            book.setName(rs.getString("title"));
            book.setPrice(Integer.parseInt(rs.getString("price")));
            book.setQuantity(1);
            book.setRegdate(rs.getDate("regdate"));
            String author=rs.getString("author");
			if(author.contains("정보 더 보기")) {
			author=author.substring(0,author.lastIndexOf("정보 더 보기"));
			}
			book.setAuthor(author.trim());
            book.setPublisher(rs.getString("publisher"));
            book.setSaleRate(rs.getInt("salerate"));
            book.setScore(rs.getInt("score"));
            book.setIsbn(rs.getString("isbn"));
            book.setBsize(rs.getString("bsize"));
            book.setState(rs.getString("state"));
            book.setTag(rs.getString("tag"));
            book.setSubCategory(rs.getString("category_id"));
            
            String content = rs.getString("content");
            Document doc1 = Jsoup.parse(content);		
    		
    		Elements elements = doc1.select("iframe");
    		for (Element element : elements) {
    			element.remove();
    		}
    		String description = doc1.html().replace("<br>", "$$");
    		Document descriptionHtml = Jsoup.parse(description);
            description = descriptionHtml.body().text().replace("$$", "\n").toString();
            book.setDescription(description);
            
            Document doc2 = Jsoup.parse(content);
            if (doc2.select("iframe") != null) {            		
                String[] href = doc2.select("iframe").attr("src").split("/");
        		String contentId = href[href.length-1];
        		book.setContentId(contentId);
			} else {
				book.setContentId(null);	
			}
            
            rs.close();

    	}catch(Exception e) {
    		  
    		e.printStackTrace();
    		
    	}finally {
    		
    	    cm.disConnection(con,psmt);
    	} 
    	return book;
    	
    }


}
