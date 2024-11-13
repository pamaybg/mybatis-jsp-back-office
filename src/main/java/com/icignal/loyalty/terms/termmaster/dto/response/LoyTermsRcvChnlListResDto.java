package com.icignal.loyalty.terms.termmaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyTermsRcvChnlListResDto extends GridPagingItemResDto{

	private String rid;
	private String verRid;
	private String createDate;
	private String modifyDate;
	private String createBy;
	private String modifyBy;
	private String flag;
	private String ridTerms;
	private String startDate;
	@MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "useYnCd")
	private String useYn;
	private String useYnCd;
	
	@MarkName(groupCode = "LOY_CUST_AGRE_TYPE_CD", codeField = "mktRcvChnlCd")
	private String mktRcvChnlCdNm;
	private String mktRcvChnlCd;
	
	private String seqNo;
	

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getVerRid() {
		return verRid;
	}
	public void setVerRid(String verRid) {
		this.verRid = verRid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getRidTerms() {
		return ridTerms;
	}
	public void setRidTerms(String ridTerms) {
		this.ridTerms = ridTerms;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getUseYnCd() {
		return useYnCd;
	}
	public void setUseYnCd(String useYnCd) {
		this.useYnCd = useYnCd;
	}
	public String getMktRcvChnlCd() {
		return mktRcvChnlCd;
	}
	public void setMktRcvChnlCd(String mktRcvChnlCd) {
		this.mktRcvChnlCd = mktRcvChnlCd;
	}
	public String getMktRcvChnlCdNm() {
		return mktRcvChnlCdNm;
	}
	public void setMktRcvChnlCdNm(String mktRcvChnlCdNm) {
		this.mktRcvChnlCdNm = mktRcvChnlCdNm;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	
}
