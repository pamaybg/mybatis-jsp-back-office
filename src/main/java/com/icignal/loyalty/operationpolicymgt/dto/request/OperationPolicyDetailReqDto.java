package com.icignal.loyalty.operationpolicymgt.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class OperationPolicyDetailReqDto extends CommonDataAuthReqDto {
	
	// 멤버필드
	private String rid;
	private String flag;
	private String ridOpr;
	private String parRid;
	private String attrCd;
	private String dataType;
	private String dataVal;
	private String contents;
	private String useYn;
	private String groupCd;
		
	private String oprDtlRid;  // 정책속성값(서브그리드1), 세부사항(서브그리드2) 등에 어떤 데이터 상호작용(처리)가 일어날 때 마다, 그에 대한 히스토리를 기억하기 위해 사용되는 해당 처리건의 rid값을 담는 필드
	private String singleValYn; // 단일값여부
	private String dataValMarkNm; // dataVal값(+그와 함께 있는 group_code값)에 대한 MarkName 필드 
	 

	// 게터세터	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getRidOpr() {
		return ridOpr;
	}

	public void setRidOpr(String ridOpr) {
		this.ridOpr = ridOpr;
	}

	public String getParRid() {
		return parRid;
	}

	public void setParRid(String parRid) {
		this.parRid = parRid;
	}

	public String getAttrCd() {
		return attrCd;
	}

	public void setAttrCd(String attrCd) {
		this.attrCd = attrCd;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getDataVal() {
		return dataVal;
	}

	public void setDataVal(String dataVal) {
		this.dataVal = dataVal;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getOprDtlRid() {
		return oprDtlRid;
	}

	public void setOprDtlRid(String oprDtlRid) {
		this.oprDtlRid = oprDtlRid;
	}
	
	public String getGroupCd() {
		return groupCd;
	}
	public void setGroupCd(String groupCd) {
		this.groupCd = groupCd;
	}

	public String getSingleValYn() {
		return singleValYn;
	}

	public void setSingleValYn(String singleValYn) {
		this.singleValYn = singleValYn;
	}

	public String getDataValMarkNm() {
		return dataValMarkNm;
	}

	public void setDataValMarkNm(String dataValMarkNm) {
		this.dataValMarkNm = dataValMarkNm;
	}
}
