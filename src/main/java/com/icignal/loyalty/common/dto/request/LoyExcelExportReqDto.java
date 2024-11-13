package com.icignal.loyalty.common.dto.request;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyExcelExportReqDto extends CommonDataAuthReqDto {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private String fileName;
	private List<String> headerName;
	private List<Object> header;
	private List<Object> data;
	private String actionUrl;
	private HashMap<String,Object> postData;
	private String gridId;
	private List<Map<String, String>> newData;

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
	/**
	* @return the actionUrl
	*/
	public String getActionUrl() {
		return actionUrl;
	}
	/**
	* @param actionUrl the actionUrl to set
	*/
	public void setActionUrl(String actionUrl) {
		this.actionUrl = actionUrl;
	}
	/**
	* @return the postData
	*/
	public HashMap<String,Object> getPostData() {
		return postData;
	}
	/**
	* @param postData the postData to set
	*/
	public void setPostData(HashMap<String,Object> postData) {
		this.postData = postData;
	}
	/**
	* @return the gridId
	*/
	public String getGridId() {
		return gridId;
	}
	/**
	* @param gridId the gridId to set
	*/
	public void setGridId(String gridId) {
		this.gridId = gridId;
	}
	/**
	* @return the newData
	*/
	public List<Map<String, String>> getNewData() {
		return newData;
	}
	/**
	* @param newData the newData to set
	*/
	public void setNewData(List<Map<String, String>> newData) {
		this.newData = newData;
	}





}
