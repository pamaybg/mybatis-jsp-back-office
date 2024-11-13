package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 14.
 * @author : 이원준
 * @description : 공통코드 ResponseDTO
 */
public class KprComboListResDto extends GridPagingItemResDto  {
	
	
    private String id;     		//아이디
    private String text;     		//명
    private String dbType;     //DB유형
    
	public String getDbType() {
		return dbType;
	}
	public void setDbType(String dbType) {
		this.dbType = dbType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
    

}
