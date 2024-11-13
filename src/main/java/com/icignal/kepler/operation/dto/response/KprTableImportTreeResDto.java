package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 8. 4.
 * @author : LEE
 * @description : 테이블 불러오기 ResponseDTO
 */
public class KprTableImportTreeResDto extends StatusResDto {

	
	private String id; // 아이디
	private String text; // 명
	private String parentId; // 부모아이디
	private String tblNm; // 테이블명
	private String schmaNm; // 스키마명
	private String nodeType; // 스키마명
	private String comment; // 코멘트
	private String engine;
	private String mySql; // 스키마명

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

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getTblNm() {
		return tblNm;
	}

	public void setTblNm(String tblNm) {
		this.tblNm = tblNm;
	}

	public String getSchmaNm() {
		return schmaNm;
	}

	public void setSchmaNm(String schmaNm) {
		this.schmaNm = schmaNm;
	}

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getEngine() {
		return engine;
	}

	public void setEngine(String engine) {
		this.engine = engine;
	}

	public String getMySql() {
		return mySql;
	}

	public void setMySql(String mySql) {
		this.mySql = mySql;
	}
}