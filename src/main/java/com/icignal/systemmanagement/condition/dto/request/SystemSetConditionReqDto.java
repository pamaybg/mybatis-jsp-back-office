package com.icignal.systemmanagement.condition.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;


/**
 * @name : setCondition
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 조건 저장
 */
public class SystemSetConditionReqDto extends MKTBaseReqDto {
	
	private String id;			//조건 아이디
	private String empId;		//직원 아이디
	private String condName;	//조건 명
	private String condType;	//조건 유형
	private String dropDownCD;	//드랍다운 코드
	private String defaultCond;	//초기 조건
	private String baseTable;	//기본 테이블
	private String tgTable;		//대상 테이블
	private String tgCol;		//대상 컬럼
	private String comTgCol;	//비교 대상 컬럼
	private String srcCol;		//소스 컬럼
	private String pageId;		//화면 아이디
	
	private String baseTblAlias;		//베이스테이블 얼리어스
	private String comprTgtTblAlias;	//비교대상테이블 얼리어스
	private String ddlValTypeCd;
	private String ddlVwCnCol;
	private String ddlVwMnCol;

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
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

	public String getDefaultCond() {
		return defaultCond;
	}

	public void setDefaultCond(String defaultCond) {
		this.defaultCond = defaultCond;
	}

	public String getBaseTable() {
		return baseTable;
	}

	public void setBaseTable(String baseTable) {
		this.baseTable = baseTable;
	}

	public String getTgTable() {
		return tgTable;
	}

	public void setTgTable(String tgTable) {
		this.tgTable = tgTable;
	}

	public String getTgCol() {
		return tgCol;
	}

	public void setTgCol(String tgCol) {
		this.tgCol = tgCol;
	}

	public String getComTgCol() {
		return comTgCol;
	}

	public void setComTgCol(String comTgCol) {
		this.comTgCol = comTgCol;
	}

	public String getSrcCol() {
		return srcCol;
	}

	public void setSrcCol(String srcCol) {
		this.srcCol = srcCol;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPageId() {
		return pageId;
	}

	public void setPageId(String pageId) {
		this.pageId = pageId;
	}

	public String getDropDownCD() {
		return dropDownCD;
	}

	public void setDropDownCD(String dropDownCD) {
		this.dropDownCD = dropDownCD;
	}

	public String getBaseTblAlias() {
		return baseTblAlias;
	}

	public void setBaseTblAlias(String baseTblAlias) {
		this.baseTblAlias = baseTblAlias;
	}

	public String getComprTgtTblAlias() {
		return comprTgtTblAlias;
	}

	public void setComprTgtTblAlias(String comprTgtTblAlias) {
		this.comprTgtTblAlias = comprTgtTblAlias;
	}

	public String getDdlValTypeCd() {
		return ddlValTypeCd;
	}

	public void setDdlValTypeCd(String ddlValTypeCd) {
		this.ddlValTypeCd = ddlValTypeCd;
	}

	public String getDdlVwCnCol() {
		return ddlVwCnCol;
	}

	public void setDdlVwCnCol(String ddlVwCnCol) {
		this.ddlVwCnCol = ddlVwCnCol;
	}

	public String getDdlVwMnCol() {
		return ddlVwMnCol;
	}

	public void setDdlVwMnCol(String ddlVwMnCol) {
		this.ddlVwMnCol = ddlVwMnCol;
	}
	
}
