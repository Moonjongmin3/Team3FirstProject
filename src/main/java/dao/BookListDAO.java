package dao;
import java.util.*;
import java.sql.*;
import vo.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
public class BookListDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ConnectionManager cm = new ConnectionManager();
	
	public List<BookVO> bookSearchList(int category,String keyword,int page) {
		List<BookVO> list = new ArrayList<>();
		try {
			conn=cm.getConnection();
			String main="";
			if(category==4) {
				 main="s.main_id in(1,2,3)";
			}else {
				main=" s.main_id="+category;
			}
//			type= "title LIKE '%'||?||'%' OR content LIKE '%'||?||'%'"
			String sql="SELECT id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,main,score,num "
					+ "FROM (SELECT id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,main,score,rownum as num "
					+ "FROM (SELECT b.id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,s.main_id as main,score "
					+ "FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and "+main+" and (title LIKE '%'||?||'%' OR author LIKE '%'||?||'%' OR publisher LIKE '%'||?||'%') "
					+ "ORDER BY sell_count DESC)) "
					+ "WHERE num between ? and ?";
			ps=conn.prepareStatement(sql);
			
			int rowSize=10;
			int startpage=(rowSize*page)-(rowSize-1);
			int endpage=rowSize*page;
			
			ps.setString(1, keyword);
			ps.setString(2, keyword);
			ps.setString(3, keyword);
			ps.setInt(4, startpage);
			ps.setInt(5, endpage);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				BookVO vo = new BookVO();
				vo.setId(rs.getInt(1));
				vo.setSubCategory(rs.getString(2));
				vo.setName(rs.getString(3));
				String author=rs.getString(4);
				if(author.contains("정보 더 보기")) {
				author=author.substring(0,author.lastIndexOf("정보 더 보기"));
				}
				vo.setAuthor(author.trim());
				vo.setPublisher(rs.getString(5));
				vo.setRegdate(rs.getDate(6));
				vo.setPoster(rs.getString(7));
				String content=rs.getString(8);
				if(content!=null) {
					Document doc = Jsoup.parse(content);
					Elements elements = doc.select("iframe");
                    for (Element element : elements) {
                        element.remove();
                    }
                    String description = doc.html().replace("<br>", "$$");
                    Document descriptionHtml = Jsoup.parse(description);
                    description = descriptionHtml.body().text().replace("$$", "\n").toString();
                    vo.setDescription(description);
				}else {
					vo.setDescription(rs.getString(8));
				}
				vo.setPrice(rs.getInt(9));
				vo.setSaleRate(rs.getInt(10));
				vo.setState(rs.getString(11));
				vo.setTag(rs.getString(12));
				vo.setSellCount(rs.getInt(13));
				vo.setMainCategory(rs.getString(14));
				vo.setScore(rs.getInt(15));
				
				list.add(vo);
				
			}
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		} 
		finally {
			cm.disConnection(conn, ps);
		}
		return list;
	}
	
	public int searchTotalCount(int category,String keyword) {
		int count= 0;
		try {
			conn=cm.getConnection();
			String main="";
			if(category==4) {
				 main="s.main_id in(1,2,3)";
			}else {
				main=" s.main_id="+category;
			}
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and "+main+" and "
					+ "(title LIKE '%'||?||'%' OR author LIKE '%'||?||'%' OR publisher LIKE '%'||?||'%')"; 
			ps=conn.prepareStatement(sql);

			ps.setString(1, keyword);
			ps.setString(2, keyword);
			ps.setString(3, keyword);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			cm.disConnection(conn, ps);
		}
		
		return count;
	}
	
	public int searchBookCount(int category,String keyword) {
		int count= 0;
		try {
			conn=cm.getConnection();
			String main="";
			if(category==4) {
				 main="s.main_id in(1,2,3)";
			}else {
				main=" s.main_id="+category;
			}
			String sql="SELECT COUNT(*) FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and "+main+" and "
					+ "(title LIKE '%'||?||'%' OR author LIKE '%'||?||'%' OR publisher LIKE '%'||?||'%')"; 
			ps=conn.prepareStatement(sql);

			ps.setString(1, keyword);
			ps.setString(2, keyword);
			ps.setString(3, keyword);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			cm.disConnection(conn, ps);
		}
		
		return count;
	}
	
	public List<BookCountVO> searchBookCount (String keyword) {
		List<BookCountVO> list = new ArrayList<BookCountVO>();
		try {
			conn=cm.getConnection();
			String sql="SELECT s.main_id,b.category_id,COUNT(*) "
					+ "FROM BOOKS_3 b, SUB_CATEGORY_3 s "
					+ "WHERE b.category_id=s.id AND "
					+ "(b.title LIKE '%'||'?'||'%' OR b.author LIKE '%'||'?'||'%' OR b.publisher LIKE '%'||'?'||'%') "
					+ "GROUP BY GROUPING SETS  ((b.category_id, s.main_id),()) ORDER BY category_id;";
			ps=conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, keyword);
			ps.setString(3, keyword);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BookCountVO vo = new BookCountVO();
				vo.setMainCount(rs.getInt(1));
				vo.setSubCount(rs.getInt(2));
				vo.setCount(rs.getInt(3));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			cm.disConnection(conn, ps);
		}
		
		return list;
	}
	
}
