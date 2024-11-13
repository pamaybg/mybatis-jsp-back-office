package com.icignal.common.base.dto.request;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GridExcelExportReqDto extends CommonDataAuthReqDto {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private String fileName;
	private List<String> headerName; 
	private List<Object> header;
	private List<Object> data;
	
	public HttpServletRequest getRequest() {
		return request;
	}
	
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	
	public HttpServletResponse getResponse() {
		return response;
	}
	
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	public List<Object> getHeader() {
		if (this.header == null) {
			this.header = new ArrayList<Object>();
		}
		return header;
	}
	
	public void setHeader(List<Object> header) {
		this.header = header;
	}
	
	public List<Object> getData() {
		if (this.data == null) {
			this.data = new ArrayList<Object>();
		}
		return data;
	}
	
	public void setData(List<Object> data) {
		this.data = data;
	}
	
	public List getHeaderName() {
		return headerName;
	}
	
	public void setHeaderName(List headerName) {
		this.headerName = headerName;
	}
	
	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}
