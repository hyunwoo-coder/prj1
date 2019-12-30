package com.group4.erp;

public class BusinessTripSearchDTO {

	private String keyword;
	private String[] date;
	private int selectPageNo=1;
	private int rowCntPerPage=10;
	private String searchKey;
	//private String ascdesc;
	//private int thindexno;
	private String sort;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String[] getDate() {
		return date;
	}
	public void setDate(String[] date) {
		this.date = date;
	}
	public int getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public int getRowCntPerPage() {
		return rowCntPerPage;
	}
	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
}
