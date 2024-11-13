package com.icignal.loyalty.custdi.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@CommCode
@PersonalData
public class LoyCustDupRstDetailResDto extends GridPagingItemResDto{

	private String rid;
	@MarkName(groupCode = "LOY_CUST_DI_TYPE_CD", codeField = "fieldCd")
	private String field;
	private String fieldCd;
	private String totalScore;
	private String score;
	private String tgtCustRid;
	@Decrypted(masked = "none")
	private String tgtCustNm;
	private String tgtBirthday;
	@Decrypted(masked = "none")
	private String tgtEmail;
	@MarkName(groupCode = "LOY_GEN_CD", codeField = "tgtGenCd")
	private String tgtGen;
	private String tgtGenCd;
	@Decrypted(masked = "none")
	private String tgtHhp;
	private String tgtCustNo;
	private String similrCustRid;
	@Decrypted(masked = "none")
	private String similrCustNm;
	private String similrBirthday;
	@Decrypted(masked = "none")
	private String similrEmail;
	@MarkName(groupCode = "LOY_GEN_CD", codeField = "similrGenCd")
	private String similrGen;
	private String similrGenCd;
	@Decrypted(masked = "none")
	private String similrHhp;
	private String similrCustNo;
	private String tgtCertVal;
	private String similrCertVal;
	private String tgtCustNmAdd;
	private String similrCustNmAdd;
	
	//사업자(단체)
	private String tgtBizrNo;
	private String tgtJurNo;
	private String tgtTelNo;
	private String similrBizrNo;
	private String similrJurNo;
	private String similrTelNo;

	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFieldCd() {
		return fieldCd;
	}
	public void setFieldCd(String fieldCd) {
		this.fieldCd = fieldCd;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getTgtCustRid() {
		return tgtCustRid;
	}
	public void setTgtCustRid(String tgtCustRid) {
		this.tgtCustRid = tgtCustRid;
	}
	public String getTgtCustNm() {
		return tgtCustNm;
	}
	public void setTgtCustNm(String tgtCustNm) {
		this.tgtCustNm = tgtCustNm;
	}
	public String getTgtBirthday() {
		return tgtBirthday;
	}
	public void setTgtBirthday(String tgtBirthday) {
		this.tgtBirthday = tgtBirthday;
	}
	public String getTgtEmail() {
		return tgtEmail;
	}
	public void setTgtEmail(String tgtEmail) {
		this.tgtEmail = tgtEmail;
	}
	public String getTgtGen() {
		return tgtGen;
	}
	public void setTgtGen(String tgtGen) {
		this.tgtGen = tgtGen;
	}
	public String getTgtHhp() {
		return tgtHhp;
	}
	public void setTgtHhp(String tgtHhp) {
		this.tgtHhp = tgtHhp;
	}
	public String getTgtCustNo() {
		return tgtCustNo;
	}
	public void setTgtCustNo(String tgtCustNo) {
		this.tgtCustNo = tgtCustNo;
	}
	public String getSimilrCustRid() {
		return similrCustRid;
	}
	public void setSimilrCustRid(String similrCustRid) {
		this.similrCustRid = similrCustRid;
	}
	public String getSimilrCustNm() {
		return similrCustNm;
	}
	public void setSimilrCustNm(String similrCustNm) {
		this.similrCustNm = similrCustNm;
	}
	public String getSimilrBirthday() {
		return similrBirthday;
	}
	public void setSimilrBirthday(String similrBirthday) {
		this.similrBirthday = similrBirthday;
	}
	public String getSimilrEmail() {
		return similrEmail;
	}
	public void setSimilrEmail(String similrEmail) {
		this.similrEmail = similrEmail;
	}
	public String getSimilrGen() {
		return similrGen;
	}
	public void setSimilrGen(String similrGen) {
		this.similrGen = similrGen;
	}
	public String getSimilrHhp() {
		return similrHhp;
	}
	public void setSimilrHhp(String similrHhp) {
		this.similrHhp = similrHhp;
	}
	public String getSimilrCustNo() {
		return similrCustNo;
	}
	public void setSimilrCustNo(String similrCustNo) {
		this.similrCustNo = similrCustNo;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getTgtGenCd() {
		return tgtGenCd;
	}
	public void setTgtGenCd(String tgtGenCd) {
		this.tgtGenCd = tgtGenCd;
	}
	public String getSimilrGenCd() {
		return similrGenCd;
	}
	public void setSimilrGenCd(String similrGenCd) {
		this.similrGenCd = similrGenCd;
	}
	public String getTgtCertVal() {
		return tgtCertVal;
	}
	public void setTgtCertVal(String tgtCertVal) {
		this.tgtCertVal = tgtCertVal;
	}
	public String getSimilrCertVal() {
		return similrCertVal;
	}
	public void setSimilrCertVal(String similrCertVal) {
		this.similrCertVal = similrCertVal;
	}
	
	public String getTgtCustNmAdd() {
		return tgtCustNmAdd;
	}
	public void setTgtCustNmAdd(String tgtCustNmAdd) {
		this.tgtCustNmAdd = tgtCustNmAdd;
	}
	public String getSimilrCustNmAdd() {
		return similrCustNmAdd;
	}
	public void setSimilrCustNmAdd(String similrCustNmAdd) {
		this.similrCustNmAdd = similrCustNmAdd;
	}
	/**
	 * 사업자 단체
	 * */
	
	public String getTgtBizrNo() {
		return tgtBizrNo;
	}
	public void setTgtBizrNo(String tgtBizrNo) {
		this.tgtBizrNo = tgtBizrNo;
	}
	public String getTgtJurNo() {
		return tgtJurNo;
	}
	public void setTgtJurNo(String tgtJurNo) {
		this.tgtJurNo = tgtJurNo;
	}
	public String getSimilrBizrNo() {
		return similrBizrNo;
	}
	public void setSimilrBizrNo(String similrBizrNo) {
		this.similrBizrNo = similrBizrNo;
	}
	public String getSimilrJurNo() {
		return similrJurNo;
	}
	public void setSimilrJurNo(String similrJurNo) {
		this.similrJurNo = similrJurNo;
	}
	public String getTgtTelNo() {
		return tgtTelNo;
	}
	public void setTgtTelNo(String tgtTelNo) {
		this.tgtTelNo = tgtTelNo;
	}
	public String getSimilrTelNo() {
		return similrTelNo;
	}
	public void setSimilrTelNo(String similrTelNo) {
		this.similrTelNo = similrTelNo;
	}
}
