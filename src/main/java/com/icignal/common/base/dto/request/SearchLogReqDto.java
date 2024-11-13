package com.icignal.common.base.dto.request;

import java.util.Date;


 
public class SearchLogReqDto extends BaseReqDto{

	private String search_key;
	private String field;
	private String operation;
	private String value1;
	private String value2;
	private String user_rid;
	private String url;
	private String url_include;
	private Date date;
	public String getSearch_key() {
		return search_key;
	}
	public void setSearch_key(String search_key) {
		this.search_key = search_key;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getValue1() {
		return value1;
	}
	public void setValue1(String value1) {
		this.value1 = value1;
	}
	public String getUser_rid() {
		return user_rid;
	}
	public void setUser_rid(String user_rid) {
		this.user_rid = user_rid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUrl_include() {
		return url_include;
	}
	public void setUrl_include(String url_include) {
		this.url_include = url_include;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getValue2() {
		return value2;
	}
	public void setValue2(String value2) {
		this.value2 = value2;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	
	
	
	
}


