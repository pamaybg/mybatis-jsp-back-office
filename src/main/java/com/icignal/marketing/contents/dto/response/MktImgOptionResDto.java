package com.icignal.marketing.contents.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : AccountFileUploadResponseDTO 
 * @date : 2015. 05. 07.
 * @author : 홍성호
 */ 
public class MktImgOptionResDto extends GridPagingItemResDto{
	private String name;
	private int height;
	private int width;
	private String accntId;
	
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}

	
	
	
}
