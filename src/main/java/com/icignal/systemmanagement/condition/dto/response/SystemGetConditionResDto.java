package com.icignal.systemmanagement.condition.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : getConditionList
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 조건 목록 조회
 */
@PersonalData
@CommCode
public class SystemGetConditionResDto extends GridPagingItemResDto {

	private String condId;		//조건 아이디
	private String menuName; 	//페이지 명
	private String condName;	//조건 명
	
	@MarkName(groupCode="MKT_SEARCH_TYPE_CD",codeField="condCd")
	private String condType;	//조건 유형
	
	private String condCd;
	
	private String tableName;	//테이블 명
	private String tgtTable;	//대상 테이블
	private String tgtClm;		//비교대상 컬럼
	private String joinSrcClm;	//조인 소스 컬
	private String joinTgtClm;	///조인 대상 컬럼
	
	//@MarkName(groupCode="COMM_STATUS",codeField="defaultCd")
	private String defaultCond;	//초기 조건
	
	private String defaultCd;
	
	public String getCondId() {
		return condId;
	}
	public void setCondId(String condId) {
		this.condId = condId;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getCondName() {
		return condName;
	}
	public void setCondName(String condName) {
		this.condName = condName;
	}
	public String getCondType() {
		return condType;
	}
	public void setCondType(String condType) {
		this.condType = condType;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTgtTable() {
		return tgtTable;
	}
	public void setTgtTable(String tgtTable) {
		this.tgtTable = tgtTable;
	}
	public String getTgtClm() {
		return tgtClm;
	}
	public void setTgtClm(String tgtClm) {
		this.tgtClm = tgtClm;
	}
	public String getJoinSrcClm() {
		return joinSrcClm;
	}
	public void setJoinSrcClm(String joinSrcClm) {
		this.joinSrcClm = joinSrcClm;
	}
	public String getJoinTgtClm() {
		return joinTgtClm;
	}
	public void setJoinTgtClm(String joinTgtClm) {
		this.joinTgtClm = joinTgtClm;
	}
	public String getDefaultCond() {
		return defaultCond;
	}
	public void setDefaultCond(String defaultCond) {
		this.defaultCond = defaultCond;
	}
	public String getCondCd() {
		return condCd;
	}
	public void setCondCd(String condCd) {
		this.condCd = condCd;
	}
	public String getDefaultCd() {
		return defaultCd;
	}
	public void setDefaultCd(String defaultCd) {
		this.defaultCd = defaultCd;
	}
	
	
}
