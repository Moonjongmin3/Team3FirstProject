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
	public List<BookVO> bookSearchList(SearchVO vo) {
		List<BookVO> list = new ArrayList<>();
		try {
			 StringBuffer sbSql = new StringBuffer("SELECT id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,main,score,sub_name,num "
					+ "FROM (SELECT id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,main,score,sub_name,rownum as num "
					+ "FROM (SELECT b.id,category_id,title,author,publisher,regdate,poster,content,price,salerate,state,tag,sell_count,s.main_id as main,score,s.name,s.NAME as sub_name "
					+ "FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and ");
			 // 메인카테고리
			String main="";
			if(vo.getMainCategory()==4) {
				main = "s.main_id in(1,2,3) ";
				sbSql.append(main);
			}else {
				main="s.main_id="+vo.getMainCategory();
				sbSql.append(main);
			}
			// 검색어
			String tapt="";
			if(vo.getKeywordExcept().equals("N")) {
			tapt="AND (";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%' OR ";
					}else {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%') ";
					}
				}
			}
			sbSql.append(tapt);
			
			// 품절 여부
			String except=vo.getStockCheck();
			if(except.equals("N")) {
				String exsql="AND state LIKE '%'||'판매'||'%' ";
				sbSql.append(exsql);
			}
			
			// sub_category 분류
			if(!(vo.getSubcategory()[0].equals("all"))) {
				String subcate="AND category_id IN (";
				for(int i=0; i<vo.getSubcategory().length;i++) {
					if(i!=vo.getSubcategory().length-1) {
						subcate+=vo.getSubcategory()[i]+",";
					}else {
						subcate+=vo.getSubcategory()[i]+") ";
					}
				}
				sbSql.append(subcate);
			}
			
			// 정렬
			String sort="";
			if(vo.getSort().equals("sellsort")) {
				sort="ORDER BY sell_count DESC) ";
			}else if(vo.getSort().equals("day")){
				sort="ORDER BY regdate DESC) ";
			}else if(vo.getSort().equals("review")){
				sort=""; // 리뷰순
			}else if(vo.getSort().equals("price")){
				sort="ORDER BY price) ";
			}else {
				sort="ORDER BY score DESC) "; // 인기순 더 구상 필요
			}
			sbSql.append(sort);
			
			//결과내 재검색
			if(!(vo.getReKeyword().equals(""))) {
				String reKey="WHERE ";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%' OR ";
					}else {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%') ";
					}
				}
				sbSql.append(reKey);
			}else {
				sbSql.append(") ");
			}
			// rowSize
			sbSql.append("WHERE num between ? and ?");
			int rowSize=vo.getRowSize();
			int startpage=(rowSize*vo.getPage())-(rowSize-1);
			int endpage=rowSize*vo.getPage();
			
			String sql=sbSql.toString();
			conn=cm.getConnection();
			ps=conn.prepareStatement(sql);
		
			ps.setInt(1, startpage);
			ps.setInt(2, endpage);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				BookVO bvo = new BookVO();
				bvo.setId(rs.getInt(1));
				bvo.setSubCategory(rs.getString(2));
				bvo.setName(rs.getString(3));
				String author=rs.getString(4);
				if(author.contains("정보 더 보기")) {
				author=author.substring(0,author.lastIndexOf("정보 더 보기"));
				}
				bvo.setAuthor(author.trim());
				bvo.setPublisher(rs.getString(5));
				bvo.setRegdate(rs.getDate(6));
				bvo.setPoster(rs.getString(7));
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
                    bvo.setDescription(description);
				}else {
					bvo.setDescription(rs.getString(8));
				}
				bvo.setPrice(rs.getInt(9));
				bvo.setSaleRate(rs.getInt(10));
				bvo.setState(rs.getString(11));
				bvo.setTag(rs.getString(12));
				bvo.setSellCount(rs.getInt(13));
				bvo.setMainCategory(rs.getString(14));
				bvo.setScore(rs.getInt(15));
				bvo.setSubCateName(rs.getString(16));
				
				list.add(bvo);
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
	
	// 총 페이지 구하기
	public int searchTotalPage(SearchVO vo) {
		int count= 0;
		Double rowSize=(vo.getRowSize()*10.0)/10.0;
		try {
			String tmp="";
			if(!(vo.getReKeyword().equals(""))) {
				tmp="(select title,author,publisher FROM";
			}
			StringBuffer sbSql = new StringBuffer("SELECT CEIL(COUNT(*)/"+rowSize+") FROM"+ tmp+" (select title,author,publisher "
					+ "FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and ");
			String main="";
			if(vo.getMainCategory()==4) {
				main = "s.main_id in(1,2,3) ";
				sbSql.append(main);
			}else {
				main="s.main_id="+vo.getMainCategory();
				sbSql.append(main);
			}
			String tapt="";
			if(vo.getKeywordExcept().equals("N")) {
				tapt="and (";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%' OR ";
					}else {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%') ";
					}
				}
			}
			sbSql.append(tapt);
			
			String except=vo.getStockCheck();
			if(except.equals("N")) {
				String exsql="AND (state LIKE '%'||'판매'||'%') ";
				sbSql.append(exsql);
			}
			
			if(!(vo.getSubcategory()[0].equals("all"))) {
				String subcate="AND category_id IN (";
				for(int i=0; i<vo.getSubcategory().length;i++) {
					if(i!=vo.getSubcategory().length-1) {
						subcate+=vo.getSubcategory()[i]+",";
					}else {
						subcate+=vo.getSubcategory()[i]+") ";
					}
				}
				sbSql.append(subcate);
			}
			
			if(!(vo.getReKeyword().equals(""))) {
				String reKey=") WHERE ";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%' OR ";
					}else {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%')";
					}
				}
				sbSql.append(reKey);
			}else {
				sbSql.append(")");
			}
			
			String sql=sbSql.toString();
			
			conn=cm.getConnection();
			ps=conn.prepareStatement(sql);
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
	
	// 통합검색 , 국내도서, 외국도서, ebook 개수 
	public int[] searchBookCount(SearchVO vo) {
		int[] mainCount= {0,0,0,0};
		try {
			StringBuffer sbSql = new StringBuffer("SELECT nvl(MAIN_ID,0),COUNT(*) FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and ");
			String main="";
			main = "s.main_id in(1,2,3) ";
			sbSql.append(main);
		
			String tapt="";
			if(vo.getKeywordExcept().equals("N")) {
				tapt="and (";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%' OR ";
					}else {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%') ";
					}
				}
			}
			sbSql.append(tapt);
			
			String except=vo.getStockCheck();
			if(except.equals("N")) {
				String exsql="AND state LIKE '%'||'판매'||'%' ";
				sbSql.append(exsql);
			} 
			
			if(!(vo.getSubcategory()[0].equals("all"))) {
				String subcate="AND category_id IN (";
				for(int i=0; i<vo.getSubcategory().length;i++) {
					if(i!=vo.getSubcategory().length-1) {
						subcate+=vo.getSubcategory()[i]+",";
					}else {
						subcate+=vo.getSubcategory()[i]+") ";
					}
				}
				sbSql.append(subcate);
			}
			
			if(!(vo.getReKeyword().equals(""))) {
				String reKey="AND (";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%' OR ";
					}else {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%') ";
					}
				}
				sbSql.append(reKey);
			}
			
			sbSql.append("group by rollup ( MAIN_ID ) "
					+ "order by MAIN_ID nulls first");		
			String sql=sbSql.toString();
			
			conn=cm.getConnection();
			ps=conn.prepareStatement(sql);			
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
	// 검색 결과 개수
	public int searchResultCount(SearchVO vo) {
		int count=0;
		try {
			String tmp="";
			if(!(vo.getReKeyword().equals(""))) {
				tmp="(select title,author,publisher FROM";
			}
			StringBuffer sbSql = new StringBuffer("SELECT COUNT(*) FROM"+ tmp+" (select title,author,publisher "
					+ "FROM books_3 b, sub_category_3 s "
					+ "WHERE b.category_id=s.id and ");
			String main="";
			if(vo.getMainCategory()==4) {
				main = "s.main_id in(1,2,3) ";
				sbSql.append(main);
			}else {
				main="s.main_id="+vo.getMainCategory();
				sbSql.append(main);
			}
			String tapt="";
			if(vo.getKeywordExcept().equals("N")) {
				tapt="AND (";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%' OR ";
					}else {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%') ";
					}
				}
			}
			sbSql.append(tapt);
			
			if(!(vo.getSubcategory()[0].equals("all"))) {
				String subcate="AND category_id IN (";
				for(int i=0; i<vo.getSubcategory().length;i++) {
					if(i!=vo.getSubcategory().length-1) {
						subcate+=vo.getSubcategory()[i]+",";
					}else {
						subcate+=vo.getSubcategory()[i]+") ";
					}
				}
				sbSql.append(subcate);
			}
			
			String except=vo.getStockCheck();
			if(except.equals("N")) {
				String exsql="AND (state LIKE '%'||'판매'||'%') ";
				sbSql.append(exsql);
			}
			
			if(!(vo.getReKeyword().equals(""))) {
				String reKey=") WHERE ";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%' OR ";
					}else {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%')";
					}
				}
				sbSql.append(reKey);
			}else {
				sbSql.append(")");
			}
			
			String sql=sbSql.toString();
			conn=cm.getConnection();
			ps=conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			cm.disConnection(conn, ps);
		}
		return count;
	}
	// subcategory 수 구하기
	public List<BookCountVO> bookSearchCount (SearchVO vo) {
		List<BookCountVO> list = new ArrayList<BookCountVO>();
		try {
			StringBuffer sbSql = new StringBuffer("SELECT s.MAIN_ID,NVL(s.ID,0),NVL(s.NAME,(select name from MAIN_CATEGORY_3 m where m.ID=s.MAIN_ID)),count(*) "
					+ "FROM BOOKS_3 b, SUB_CATEGORY_3 s "
					+ "WHERE b.category_id=s.id AND ");
			String main="";
			if(vo.getMainCategory()==4) {
				main = "s.main_id in(1,2,3) ";
				sbSql.append(main);
			}else {
				main="s.main_id="+vo.getMainCategory();
				sbSql.append(main);
			}
			
			String tapt="";
			if(vo.getKeywordExcept().equals("N")) {
			tapt="and (";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%' OR ";
					}else {
						tapt += vo.getTaft()[i]+" LIKE '%'||'"+vo.getKeyword()+"'||'%') ";
					}
				}
			}
			sbSql.append(tapt);
			
			String except=vo.getStockCheck();
			if(except.equals("N")) {
				String exsql="AND (state LIKE '%'||'판매'||'%') ";
				sbSql.append(exsql);
			}
			
			if(!(vo.getReKeyword().equals(""))) {
				String reKey="AND (";
				for(int i=0; i<vo.getTaft().length;i++) {
					if(i!=vo.getTaft().length-1) {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%' OR ";
					}else {
						reKey += vo.getTaft()[i]+" LIKE '%'||'"+vo.getReKeyword()+"'||'%') ";
					}
				}
				sbSql.append(reKey);
			}
			
			
			sbSql.append("group by s.MAIN_ID, rollup ((s.id,s.name)) order by s.MAIN_ID,s.id nulls first");
			String sql=sbSql.toString();
			
			conn=cm.getConnection();
			ps=conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BookCountVO bvo = new BookCountVO();
				bvo.setMainId(rs.getInt(1));
				bvo.setSubId(rs.getInt(2));
				if(bvo.getSubId()!=0) {	
					bvo.setSubCateName(rs.getString(3));
					bvo.setSubCount(rs.getInt(4));
				}else {
					bvo.setMainCateName(rs.getString(3));
					bvo.setMainCount(rs.getInt(4));
				}
				list.add(bvo);
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
