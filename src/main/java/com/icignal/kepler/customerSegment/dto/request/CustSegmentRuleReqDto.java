package com.icignal.kepler.customerSegment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class CustSegmentRuleReqDto extends CommonDataAuthReqDto {

    private String custSegRuleId;       //targetGroupId 고객 세그먼트 룰 아이디
    private String accountId;           //어카운트 아이디
    private String createByName;        //등록자명
    private String segFilterId;         //필터 아이디
    private String filterSql;           //필터 SQL
    private String logicalCompId;       //로지컬컴포넌트 아이디

    private String filterSqlCount;		//필터 count SQL	
    private String custSegRuleName;     //고객 세그먼트 룰 명
    private String custSegRuleDesc;     //타겟그룹 설명

	private String comprGroupDtl;       //비교군상세
    private String dpCond;              //조건
    private String segmentId;           //세그먼트 아이디
    private int cnt;
    private String dbInformId;
    private String impFileNm;
    private String storeId;
    private String type;
    private String custRuleNm;

    private String camId;
    private String targetingHadId;
    private String segmentType;
    private String custRuleDesc;
    private String custRuleName;
    private String comprGroupTypeCode;
    private String tgtGroupId;
    private String segFilterIdForTxt;
    
    public String getCustSegRuleId() {
		return custSegRuleId;
	}
	public void setCustSegRuleId(String custSegRuleId) {
		this.custSegRuleId = custSegRuleId;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	public String getLogicalCompId() {
		return logicalCompId;
	}
	public void setLogicalCompId(String logicalCompId) {
		this.logicalCompId = logicalCompId;
	}
	public String getSegFilterId() {
		return segFilterId;
	}
	public void setSegFilterId(String segFilterId) {
		this.segFilterId = segFilterId;
	}
	public String getFilterSql() {
		return filterSql;
	}
	public void setFilterSql(String filterSql) {
		this.filterSql = filterSql;
	}
	public String getFilterSqlCount() {
		return filterSqlCount;
	}
	public void setFilterSqlCount(String filterSqlCount) {
		this.filterSqlCount = filterSqlCount;
	}
	public String getCustSegRuleName() {
		return custSegRuleName;
	}
	public void setCustSegRuleName(String custSegRuleName) {
		this.custSegRuleName = custSegRuleName;
	}
	public String getCustSegRuleDesc() {
		return custSegRuleDesc;
	}
	public void setCustSegRuleDesc(String custSegRuleDesc) {
		this.custSegRuleDesc = custSegRuleDesc;
	}
	public String getComprGroupDtl() {
		return comprGroupDtl;
	}
	public void setComprGroupDtl(String comprGroupDtl) {
		this.comprGroupDtl = comprGroupDtl;
	}
	public String getDpCond() {
		return dpCond;
	}
	public void setDpCond(String dpCond) {
		this.dpCond = dpCond;
	}
	public String getSegmentId() {
		return segmentId;
	}
	public void setSegmentId(String segmentId) {
		this.segmentId = segmentId;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
	public String getImpFileNm() {
		return impFileNm;
	}
	public void setImpFileNm(String impFileNm) {
		this.impFileNm = impFileNm;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCustRuleNm() {
		return custRuleNm;
	}
	public void setCustRuleNm(String custRuleNm) {
		this.custRuleNm = custRuleNm;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getTargetingHadId() {
		return targetingHadId;
	}
	public void setTargetingHadId(String targetingHadId) {
		this.targetingHadId = targetingHadId;
	}
	public String getSegmentType() {
		return segmentType;
	}
	public void setSegmentType(String segmentType) {
		this.segmentType = segmentType;
	}
	public String getCustRuleDesc() {
		return custRuleDesc;
	}
	public void setCustRuleDesc(String custRuleDesc) {
		this.custRuleDesc = custRuleDesc;
	}
	public String getCustRuleName() {
		return custRuleName;
	}
	public void setCustRuleName(String custRuleName) {
		this.custRuleName = custRuleName;
	}
	public String getComprGroupTypeCode() {
		return comprGroupTypeCode;
	}
	public void setComprGroupTypeCode(String comprGroupTypeCode) {
		this.comprGroupTypeCode = comprGroupTypeCode;
	}
	public String getTgtGroupId() {
		return tgtGroupId;
	}
	public void setTgtGroupId(String tgtGroupId) {
		this.tgtGroupId = tgtGroupId;
	}
	public String getSegFilterIdForTxt() {
		return segFilterIdForTxt;
	}
	public void setSegFilterIdForTxt(String segFilterIdForTxt) {
		this.segFilterIdForTxt = segFilterIdForTxt;
	}
    

}
