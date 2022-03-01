package vo;

public class SearchVO {
	int mainCategory;
	int subcategory;
	String keyword;
	String bookinfocate;
	int stockCheck;
	String sort;
	int rowSize;
	int keywordExcept;
	public int getMainCategory() {
		return mainCategory;
	}
	public void setMainCategory(int mainCategory) {
		this.mainCategory = mainCategory;
	}
	public int getSubcategory() {
		return subcategory;
	}
	public void setSubcategory(int subcategory) {
		this.subcategory = subcategory;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getBookinfocate() {
		return bookinfocate;
	}
	public void setBookinfocate(String bookinfocate) {
		this.bookinfocate = bookinfocate;
	}
	public int getStockCheck() {
		return stockCheck;
	}
	public void setStockCheck(int stockCheck) {
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
	public int getKeywordExcept() {
		return keywordExcept;
	}
	public void setKeywordExcept(int keywordExcept) {
		this.keywordExcept = keywordExcept;
	}
	
}
