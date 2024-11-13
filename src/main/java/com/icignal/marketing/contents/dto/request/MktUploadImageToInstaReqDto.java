package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktUploadImageToInstaReqDto extends CommonDataAuthReqDto{

	private String username;
	private String password;
	private String[] imageInfo;
	private String[] file;
	private String contents;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String[] getImageInfo() {
		String[] ret = null; 
		if ( this.imageInfo != null ) { 
		    // private 배열의 복제본을 만들어서 수정 방지
		   ret = new String[imageInfo.length]; 
		   for (int i = 0; i < imageInfo.length; i++) { ret[i] = this.imageInfo[i]; } 
	   } 
	  return ret;
	}
	
	// 객체가 클래스의 private member를 수정하지 않도록 한다
	public void setImageInfo(String[] imageInfo) {
//		this.imageInfo = imageInfo;
	   this.imageInfo = new String[imageInfo.length];
	   for (int i = 0; i < imageInfo.length; ++i)   this.imageInfo[i] = imageInfo[i]; 
		
	}
	
	public String[] getFile() {
	   String[] ret = null; 
	   if ( this.file != null ) { 
	    // private 배열의 복제본을 만들어서 수정 방지
	     ret = new String[file.length]; 
	     for (int i = 0; i < file.length; i++) { ret[i] = this.file[i]; } 
	   }
	   
	   return ret;	
	}
	
	// 객체가 클래스의 private member를 수정하지 않도록 한다
	public void setFile(String[] file) {
	//	this.file = file;
		this.file = new String[file.length];
		for (int i = 0; i < file.length; ++i)   this.file[i] = file[i]; 
	}
	
	
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
}
