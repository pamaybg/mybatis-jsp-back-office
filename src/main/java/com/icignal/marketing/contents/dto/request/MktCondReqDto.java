package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;



/**
 * @name : MKTContentResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 개인화 속성 조회
 */
public class MktCondReqDto extends MKTBaseReqDto {
	private String id;                 //id
	private String condName;           //조건 명
	private String name;               //아이디
	private String schName;            //스키마 명
	private String tblName;            //테이블 명
	private String colName;            //컬럼 명
    private String markName;           //마크네임
    private String phoneNum;           //폰 번호
    private String contentTypeCodeValue; 	//컨텐츠 타입에 따른 개인화 속성 조회 코드
    
    

	public String getContentTypeCodeValue() {
		return contentTypeCodeValue;
	}
	public void setContentTypeCodeValue(String contentTypeCodeValue) {
		this.contentTypeCodeValue = contentTypeCodeValue;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTblName() {
		return tblName;
	}
	public void setTblName(String tblName) {
		this.tblName = tblName;
	}
	public String getColName() {
		return colName;
	}
	public void setColName(String colName) {
		this.colName = colName;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getSchName() {
		return schName;
	}
	public void setSchName(String schName) {
		this.schName = schName;
	}
	public String getCondName() {
		return condName;
	}
	public void setCondName(String condName) {
		this.condName = condName;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
