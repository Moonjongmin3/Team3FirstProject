package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import Common.DBConnPool;
import vo.BookCountVO;
import vo.BookVO;

public class BookDAO {

    private final static String INSERT_Q = "INSERT INTO BOOKS VALUES (?,?,?,?)";
    private Connection con;
    private PreparedStatement psmt;
    private Statement stmt;
    ConnectionManager cm = new ConnectionManager();

	public void insert(BookVO book) {
        try {
            con = cm.getConnection();

            psmt = con.prepareStatement(INSERT_Q);
            psmt.setInt(1,book.getId());
            psmt.setString(2,book.getName());
            psmt.setString(3,book.getPoster());
            psmt.setInt(4, book.getPrice());

            psmt.executeUpdate();
            System.out.println("데이터 입력 완료!");
        } catch (Exception e) {
            System.out.println("데이터 입력 실패...");
            e.printStackTrace();
        }finally {
           cm.disConnection(con,psmt);
        }
    }


    public List<BookVO> selectList(Map<String, Object> map) {
        List<BookVO> books = new Vector<BookVO>();
        String sortBy = map.get("sortBy").toString();

        String query = "SELECT * FROM ("
        				+ "SELECT Tb.*, rownum rNum from("
        				+ "SELECT b.*, mc.NAME main_category, sc.NAME sub_category FROM BOOKS_3 b "
        				+ "INNER JOIN SUB_CATEGORY_3 sc ON b.CATEGORY_ID = sc.ID "
        		        + "INNER JOIN MAIN_CATEGORY_3 mc ON sc.MAIN_ID = mc.ID ";
        
        if (map.get("searchWord") != null) {
            query += " WHERE b.TITLE LIKE '%" + map.get("searchWord") + "%' ";
        }
        
        query += "ORDER BY " + sortBy + " DESC ) Tb ) WHERE rNum BETWEEN ? AND ?";
        
        try {
            con = cm.getConnection();

             psmt = con.prepareStatement(query);

             psmt.setString(1, map.get("start").toString());
             psmt.setString(2, map.get("end").toString());

            ResultSet rs = psmt.executeQuery();
            
            while (rs.next()) {
                BookVO book = new BookVO();
                book.setId(rs.getInt("id"));
                book.setPoster(rs.getString("poster"));
                book.setName(rs.getString("title"));
                book.setPrice(Integer.parseInt(rs.getString("price")));
                book.setQuantity(1);
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setSaleRate(rs.getInt("salerate"));
                book.setScore(rs.getInt("score"));
                book.setIsbn(rs.getString("isbn"));
                book.setBsize(rs.getString("bsize"));
                book.setState(rs.getString("state"));
                book.setTag(rs.getString("tag"));
                book.setMainCategory(rs.getString("main_category"));
                book.setSubCategory(rs.getString("sub_category"));
                
                // 책 설명 추출
                String content = rs.getString("content");
                	if(content!=null) {
                    Document doc = Jsoup.parse(content);

                    Elements elements = doc.select("iframe");
                    for (Element element : elements) {
                        element.remove();
                    }
                    String description = doc.html().replace("<br>", "$$");
                    Document descriptionHtml = Jsoup.parse(description);
                    description = descriptionHtml.body().text().replace("$$", "\n").toString();
                    book.setDescription(description);
                	}

                // 유튜브 주소 추출
               if(content!=null) 	{
	                if(content.contains("iframe")) {
	                	Document doc2 = Jsoup.parse(content);
	                	if (doc2.select("iframe") != null)      {       		
		                    String[] href = doc2.select("iframe").attr("src").split("/");
		            		String contentId = href[href.length-1];
		            		book.setContentId(contentId);
	                	}
	                }else {
						book.setContentId(null);	
					}
               }
                books.add(book);
            }
            rs.close();

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }

        return books;
    }
    public List<BookVO> selectYoutubeList() {
        List<BookVO> books = new Vector<BookVO>();

        String query = "SELECT * FROM ("
        				+ "SELECT Tb.*, rownum rNum from("
        				+ "SELECT b.*, mc.NAME main_category, sc.NAME sub_category FROM BOOKS_3 b "
                        + "INNER JOIN SUB_CATEGORY_3 sc ON b.CATEGORY_ID = sc.ID "
                        + "INNER JOIN MAIN_CATEGORY_3 mc ON sc.MAIN_ID = mc.ID "
        				+ "WHERE b.content LIKE '%youtube.com%' ORDER BY sell_count"
        				+ " DESC ) Tb ) WHERE rNum BETWEEN 1 AND 3";        
        try {
             con = cm.getConnection();
             stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                BookVO book = new BookVO();
                book.setId(rs.getInt("id"));
                book.setPoster(rs.getString("poster"));
                book.setName(rs.getString("title"));
                book.setPrice(Integer.parseInt(rs.getString("price")));
                book.setQuantity(1);
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setSaleRate(rs.getInt("salerate"));
                book.setScore(rs.getInt("score"));
                book.setIsbn(rs.getString("isbn"));
                book.setBsize(rs.getString("bsize"));
                book.setState(rs.getString("state"));
                book.setTag(rs.getString("tag"));
                book.setMainCategory(rs.getString("main_category"));
                book.setSubCategory(rs.getString("sub_category"));

                // 책 설명 추출
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
                
                // 유튜브 주소 추출
                Document doc2 = Jsoup.parse(content);
                if (doc2.select("iframe") != null) {            		
                    String[] href = doc2.select("iframe").attr("src").split("/");
            		String contentId = href[href.length-1];
            		book.setContentId(contentId);
				} else {
					book.setContentId(null);	
				}

                books.add(book);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }

        return books;
    }
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수

        // 게시물 수를 얻어오는 쿼리문 작성
        String query = "SELECT COUNT(*) FROM books_3";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                    + " LIKE '%" + map.get("searchWord") + "%'";
        }

        try {
            con=cm.getConnection();
            stmt = con.createStatement();   // 쿼리문 생성
            ResultSet rs = stmt.executeQuery(query);  // 쿼리 실행
            rs.next();  // 커서를 첫 번째 행으로 이동
            totalCount = rs.getInt(1);  // 첫 번째 칼럼 값을 가져옴

        }
        catch (Exception e) {
            System.out.println("게시물 수를 구하는 중 예외 발생");
            e.printStackTrace();
        }

        return totalCount;
    }
    public BookVO findBook(String bookId) {
        BookVO book = new BookVO();

        if (bookId == null) System.out.println("책 ID를 입력받지 못했습니다.");
        String query = "SELECT b.*, mc.NAME main_category, sc.NAME sub_category "
                        + "FROM BOOKS_3 b "
                        + "INNER JOIN SUB_CATEGORY_3 sc ON b.CATEGORY_ID = sc.ID "
                        + "INNER JOIN MAIN_CATEGORY_3 mc ON sc.MAIN_ID = mc.ID "
                        + " WHERE b.ID = ?";

        try {
            con=cm.getConnection();
            psmt = con.prepareStatement(query);
            psmt.setString(1, bookId);
            ResultSet rs = psmt.executeQuery();

            while (rs.next()) {
                book = new BookVO();
                book.setId(rs.getInt("id"));
                book.setPoster(rs.getString("poster"));
                book.setName(rs.getString("title"));
                book.setPrice(Integer.parseInt(rs.getString("price")));
                book.setQuantity(1);
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setSaleRate(rs.getInt("salerate"));
                book.setScore(rs.getInt("score"));
                book.setIsbn(rs.getString("isbn"));
                book.setBsize(rs.getString("bsize"));
                book.setState(rs.getString("state"));
                book.setTag(rs.getString("tag"));
                book.setMainCategory(rs.getString("main_category"));
                book.setSubCategory(rs.getString("sub_category"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            cm.disConnection(con,psmt);
        }

        return book;
    }
    
   public List<BookCountVO> subCateList(){
	   List<BookCountVO> list = new ArrayList<BookCountVO>();
	   try {
           con=cm.getConnection();
           String sql="SELECT id,main_id,name FROM sub_category_3 ORDER BY id ASC";
           psmt=con.prepareStatement(sql);
           ResultSet rs = psmt.executeQuery();
           while(rs.next()) {
        	   BookCountVO vo = new BookCountVO();
        	   vo.setSubId(rs.getInt(1));
        	   vo.setMainId(rs.getInt(2));
        	   vo.setSubCateName(rs.getString(3));
        	   
        	   list.add(vo);
           }
	   }catch (Exception e) {
		   e.printStackTrace();
	   }finally {
           cm.disConnection(con,psmt);
       }
	   return list;
   }
}
