package com.icignal.common.base.dto.request;

/**
 * @name : MKTCommonCodeItemRequestDTO.java
 * @date : 2015. 10. 16.
 * @author : 장용
 * @description : 공통코드
 */
public class CommonCodeItemReqDto {
	
	private String rid;			//COM_SRCH 테이블 RID
	private String condName;	//조건 명
	private String condType;	//조건 유형
	private String dropDownCD;	//드랍다운 코드
	private String defaultCond;	//초기 조건
	private String baseTable;	//기본 테이블
	private String tgTable;		//대상 테이블
	private String tgCol;		//대상 컬럼
	private String comTgCol;	//비교 대상 컬럼
	private String srcCol;		//소스 컬럼
	private String whereVal;	//조건값
	private String startDate;   //시작일
	private String endDate;		//종료일
	private String operationType;//연산자 유형   
	
	private String baseTblAlias;	//기본 테이블 별칭
	private String comprTgtTblAlias;	//비교대상테이블 별칭
	private String startTime;	//시작시간
	private String endTime;		//종료시간


	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
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
	public String getDropDownCD() {
		return dropDownCD;
	}
	public void setDropDownCD(String dropDownCD) {
		this.dropDownCD = dropDownCD;
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
	public String getWhereVal() {
		return whereVal;
	}
	public void setWhereVal(String whereVal) {
		this.whereVal = whereVal;
	}
	public String getOperationType() {
		return operationType;
	}
	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}

}