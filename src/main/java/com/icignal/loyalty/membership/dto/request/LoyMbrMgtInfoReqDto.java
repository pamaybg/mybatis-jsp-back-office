package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.commcode.MarkName;

public class LoyMbrMgtInfoReqDto extends CommonDataAuthReqDto {
	
	private String rid;
//	private String createDate;
//	private String modifyDate;
//	private String flag;
	private String ridMbr;
	private String attrCd;
//	@MarkName(groupCode="LOY_MBR_MGT_ATTR_CD",codeField="attrCd")
//	private String attrCdNm;
	private String mgtYn;
	private String attrSubCd;
//	@MarkName(groupCode="LOY_MBR_MGT_ATTR_CD",codeField="attrSubCd")
//	private String attrSubCdNm;
	private String evalCd;
//	@MarkName(groupCode="LOY_MBR_ACT_EVAL_CD",codeField="attrSubCd")	
//	private String evalCdNm;
	private String comments;
	private String ridMbrMgtAttr;
	
	
	
	// 게터세터
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
//	public String getCreateDate() {
//		return createDate;
//	}
//	public void setCreateDate(String createDate) {
//		this.createDate = createDate;
//	}
//	public String getModifyDate() {
//		return modifyDate;
//	}
//	public void setModifyDate(String modifyDate) {
//		this.modifyDate = modifyDate;
//	}
//	public String getFlag() {
//		return flag;
//	}
//	public void setFlag(String flag) {
//		this.flag = flag;
//	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getAttrCd() {
		return attrCd;
	}
	public void setAttrCd(String attrCd) {
		this.attrCd = attrCd;
	}
//	public String getAttrCdNm() {
//		return attrCdNm;
//	}
//	public void setAttrCdNm(String attrCdNm) {
//		this.attrCdNm = attrCdNm;
//	}
	public String getMgtYn() {
		return mgtYn;
	}
	public void setMgtYn(String mgtYn) {
		this.mgtYn = mgtYn;
	}
	public String getAttrSubCd() {
		return attrSubCd;
	}
	public void setAttrSubCd(String attrSubCd) {
		this.attrSubCd = attrSubCd;
	}
//	public String getAttrSubCdNm() {
//		return attrSubCdNm;
//	}
//	public void setAttrSubCdNm(String attrSubCdNm) {
//		this.attrSubCdNm = attrSubCdNm;
//	}
	public String getEvalCd() {
		return evalCd;
	}
	public void setEvalCd(String evalCd) {
		this.evalCd = evalCd;
	}
//	public String getEvalCdNm() {
//		return evalCdNm;
//	}
//	public void setEvalCdNm(String evalCdNm) {
//		this.evalCdNm = evalCdNm;
//	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getRidMbrMgtAttr() {
		return ridMbrMgtAttr;
	}
	public void setRidMbrMgtAttr(String ridMbrMgtAttr) {
		this.ridMbrMgtAttr = ridMbrMgtAttr;
	}
	

}
