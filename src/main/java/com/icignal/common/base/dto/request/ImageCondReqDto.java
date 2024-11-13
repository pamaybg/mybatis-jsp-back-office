package com.icignal.common.base.dto.request;

/**
 * @name : ImageCondRequestDTO
 * @date : 2018. 09. 11.
 * @author : 금동우
 * @description : 개인화 속성 조회
 */
public class ImageCondReqDto extends CommonDataAuthReqDto {
	private String id;                 //id
	private String condName;           //조건 명
	private String name;               //아이디
	private String schName;            //스키마 명
	private String tblName;            //테이블 명
	private String colName;            //컬럼 명
    private String markName;           //마크네임
    private String phoneNum;           //폰 번호
    private String accntId;            //어카운트 Id
    
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
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
