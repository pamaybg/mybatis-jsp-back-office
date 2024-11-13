package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 14.
 * @author : 이원준
 * @description : 공통코드 ResponseDTO
 */
public class KprTableColInfoResDto extends GridPagingItemResDto {
	
    private String colId;     		//컬럼
    private String colNm;     		//컬럼명
    private List<String> headerNm;     		//컬럼명
    private String id;     		//컬럼명
    private String text;     		//컬럼명
    
	public String getColId() {
		return colId;
	}

	public void setColId(String colId) {
		this.colId = colId;
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

	public List<String> getHeaderNm() {
		return headerNm;
	}

	public void setHeaderNm(List<String> headerNm) {
		this.headerNm = headerNm;
	}

	public String getColNm() {
		return colNm;
	}

	public void setColNm(String colNm) {
		this.colNm = colNm;
	}
    

}
