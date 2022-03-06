package vo;

public class SearchVO {
	int mainCategory; //메인 카테고리
	String[] subcategory; // 서브 카테고리
	String keyword; // 검색어
	String[] taft;  // 제목, 저자, 출판사, 태그
	String stockCheck; // 품절여부
	String sort;  // 정렬
	String reKeyword; // 검색내 검색 검색어
	int rowSize;  // n개씩 보기
	String keywordExcept; // 검색어 제외
	int page;
	
	

	public String getKeywordExcept() {
		return keywordExcept;
	}
	public void setKeywordExcept(String keywordExcept) {
		this.keywordExcept = keywordExcept;
	}
	public String getReKeyword() {
		return reKeyword;
	}
	public void setReKeyword(String reKeyword) {
		this.reKeyword = reKeyword;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getMainCategory() {
		return mainCategory;
	}
	public void setMainCategory(int mainCategory) {
		this.mainCategory = mainCategory;
	}
	public String[] getSubcategory() {
		return subcategory;
	}
	public void setSubcategory(String[] subcategory) {
		this.subcategory = subcategory;
	}
	public String[] getTaft() {
		return taft;
	}
	public void setTaft(String[] taft) {
		this.taft = taft;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getStockCheck() {
		return stockCheck;
	}
	public void setStockCheck(String stockCheck) {
		this.stockCheck = stockCheck;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public int getRowSize() {
		return rowSize;
	}
	public void setRowSize(int rowSize) {
		this.rowSize = rowSize;
	}
	
	
}
