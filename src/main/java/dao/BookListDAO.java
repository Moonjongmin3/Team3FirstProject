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
	
	/*
	 * 	   검색 조건 :main_category, sub_category, keyword, 베스트셀러, 신간도서 
	 * 				(제목,저자,출판사,태그), 검색 내 검색, 품절 포함/미포함, 10개씩/ 20개씩 보기
	 * 		검색조건을 묶은 class를 생성해서 만들기 (아직 구현x)
	 * */
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
			String sql="SELECT id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,main,score,sub_name,num "
					+ "FROM (SELECT id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,main,score,sub_name,rownum as num "
					+ "FROM (SELECT b.id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,s.main_id as main,score,s.name,s.NAME as sub_name "
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
				vo.setSubCateName(rs.getString(16));
				
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
	
	public int searchTotalPage(int category,String keyword) {
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
	
	public int[] searchBookCount(int category,String keyword) {
		int[] mainCount= {0,0,0,0};
		try {
			conn=cm.getConnection();
			String main="";
			if(category==4) {
				 main="s.main_id in(1,2,3)";
			}else {
				main=" s.main_id="+category;
			}
			String sql="SELECT nvl(MAIN_ID,0),COUNT(*) FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and "+main+" and "
					+ "(title LIKE '%'||?||'%' OR author LIKE '%'||?||'%' OR publisher LIKE '%'||?||'%') "
					+ "group by rollup ( MAIN_ID ) "
					+ "order by MAIN_ID nulls first"; 
			ps=conn.prepareStatement(sql);

			ps.setString(1, keyword);
			ps.setString(2, keyword);
			ps.setString(3, keyword);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				switch(rs.getInt(1)){
				case 0:
					mainCount[0]=rs.getInt(2);
					break;
				case 1:
					mainCount[1]=rs.getInt(2);
					break;
				case 2:
					mainCount[2]=rs.getInt(2);
					break;
				default :
					mainCount[3]=rs.getInt(2);
					break;
				}
			}
			rs.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			cm.disConnection(conn, ps);
		}
		
		return mainCount;
	}
	
	public List<BookCountVO> bookSearchCount (String keyword) {
		List<BookCountVO> list = new ArrayList<BookCountVO>();
		try {
			conn=cm.getConnection();
			String sql="SELECT s.MAIN_ID,NVL(s.ID,0),NVL(s.NAME,(select name from MAIN_CATEGORY_3 m where m.ID=s.MAIN_ID)),count(*) "
					+ "FROM BOOKS_3 b, SUB_CATEGORY_3 s "
					+ "WHERE b.category_id=s.id AND "
					+ "(b.title LIKE '%'||?||'%' OR b.author LIKE '%'||?||'%' OR b.publisher LIKE '%'||?||'%') "
					+ "group by s.MAIN_ID, rollup ((s.id,s.name)) order by s.MAIN_ID,s.id nulls first";
			ps=conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, keyword);
			ps.setString(3, keyword);
			
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BookCountVO vo = new BookCountVO();
				vo.setMainId(rs.getInt(1));
				vo.setSubId(rs.getInt(2));
				if(vo.getSubId()!=0) {	
					vo.setSubCateName(rs.getString(3));
					vo.setSubCount(rs.getInt(4));
				}else {
					vo.setMainCateName(rs.getString(3));
					vo.setMainCount(rs.getInt(4));
				}
				
				list.add(vo);
			}
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			cm.disConnection(conn, ps);
		}
		
		return list;
	}
	
}
