package com.icignal.common.apiservice.dto.response;

import java.util.ArrayList;

/**
 * 
* <pre>
* infavor.loyalty.simulation.dto.response
*  |_ LOYChnlComboResponseDTO.java
* </pre>
* @작성일		: 2017. 1. 11. 
* @작성자		: wjlee 
* @프로그램설명	:
 */
public class WebServiceSearchZipCodeResDto {

	private String success;
	private String message;
	private String errorMessage;
	private String countPerPage;
	private String totalCount;
	private String errorCode;
	private String currentPage;	
	private ArrayList<WebServiceZipCodeListResDto> juso;
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getCountPerPage() {
		return countPerPage;
	}
	public void setCountPerPage(String countPerPage) {
		this.countPerPage = countPerPage;
	}
	public String getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}
	public ArrayList<WebServiceZipCodeListResDto> getJuso() {
		return juso;
	}
	public void setJuso(ArrayList<WebServiceZipCodeListResDto> juso) {
		this.juso = juso;
	}
	
	
	
	
	
}
