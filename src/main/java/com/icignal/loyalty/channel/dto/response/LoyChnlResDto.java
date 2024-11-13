package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyChnlResDto extends GridPagingItemResDto {

	/** RID */
	private String rid;

	/** 채널 번호 */
	private String chnlNo;
	/** 채널 명 */
	private String chnlNm;

	/** 프로그램 명 */
	private String pgmNm;

	/** 채널 상태 코드 */
	private String chnlStatCd;

	/** 채널 유형 코드 */
	private String chnlTypeCd;

	/** 채널 유형 서브 코드 */
	private String chnlTypeSubCd;

	/** 채널레벌번호 */
	private String chnlLvlNo;

	/** 상위채널RID */
	private String parRid;

	/** 가입약관 RID */
	private String ridTerms;

	/** 가입약관명 */
	private String termsNm;

	/** PAR_RID_TOP */
	private String parRidTop;

	/** RID_PGM */
	private String ridPgm;

	/** RID_고객 주요 */
	private String ridCustPr;

	/** 적립 가능 여부 */
	private String acrlPsblYn;

	/** 사용 가능 여부 */
	private String usePsblYn;
	
	private String pntAcrlYn;
	
	private String pntRdmYn;

	/** 회원 가입 가능 여부 */
	private String mbrJoinPsblYn;

	/** 상위채널번호 */
	private String parChnlNo;

	/** 상위채널명 */
    private String parChnlNm;

    /** 최상위채널번호 */
    private String topChnlNo;

    /** 최상위채널명 */
    private String topChnlNm;

    /** 채널유형명*/
    @MarkName(groupCode="LOY_CHNL_TYPE_CD" , codeField="chnlTypeCd")
    private String chnlTypeNm;

    /** 상위채널 seq */
    private String parKeySeq;
    
    /** 최상위채널 seq */
	private String parKeySeqTop;
	
	/**
	 * @return the parKeySeq
	 */
	public String getParKeySeq() {
		return parKeySeq;
	}

	/**
	 * @param parChnlNo the parKeySeq to set
	 */
	public void setParKeySeq(String parKeySeq) {
		this.parKeySeq = parKeySeq;
	}

	/**
	 * @return the parKeySeqTop
	 */
	public String getParKeySeqTop() {
		return parKeySeqTop;
	}

	/**
	 * @param parChnlNo the parKeySeqTop to set
	 */
	public void setParKeySeqTop(String parKeySeqTop) {
		this.parKeySeqTop = parKeySeqTop;
	}

	/**
	 * @return the parChnlNo
	 */
	public String getParChnlNo() {
		return parChnlNo;
	}
	/**
	 * @param parChnlNo the parChnlNo to set
	 */
	public void setParChnlNo(String parChnlNo) {
		this.parChnlNo = parChnlNo;
	}
	/**
	 * @return the parChnlNm
	 */
	public String getParChnlNm() {
		return parChnlNm;
	}
	/**
	 * @param parChnlNm the parChnlNm to set
	 */
	public void setParChnlNm(String parChnlNm) {
		this.parChnlNm = parChnlNm;
	}
	/**
	 * @return the topChnlNo
	 */
	public String getTopChnlNo() {
		return topChnlNo;
	}
	/**
	 * @param topChnlNo the topChnlNo to set
	 */
	public void setTopChnlNo(String topChnlNo) {
		this.topChnlNo = topChnlNo;
	}
	/**
	 * @return the topChnlNm
	 */
	public String getTopChnlNm() {
		return topChnlNm;
	}
	/**
	 * @param topChnlNm the topChnlNm to set
	 */
	public void setTopChnlNm(String topChnlNm) {
		this.topChnlNm = topChnlNm;
	}
	/**
	 * @return the chnlTypeNm
	 */
	public String getChnlTypeNm() {
		return chnlTypeNm;
	}
	/**
	 * @param chnlTypeNm the chnlTypeNm to set
	 */
	public void setChnlTypeNm(String chnlTypeNm) {
		this.chnlTypeNm = chnlTypeNm;
	}

	/** FLAG */
	private String flag;
	/** MOD_NUM */
	private String modNum;
	/** 생성일시 */
	private String createDate;
	/** CREATE_BY */
	private String createBy;
	/** 수정일시 */
	private String modifyDate;
	/** MODIFY_BY */
	private String modifyBy;
	/**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}
	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}
	/**
	 * @return the chnlNo
	 */
	public String getChnlNo() {
		return chnlNo;
	}
	/**
	 * @param chnlNo the chnlNo to set
	 */
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	/**
	 * @return the chnlNm
	 */
	public String getChnlNm() {
		return chnlNm;
	}
	/**
	 * @param chnlNm the chnlNm to set
	 */
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	/**
	 * @return the chnlStatCd
	 */
	public String getChnlStatCd() {
		return chnlStatCd;
	}
	/**
	 * @param chnlStatCd the chnlStatCd to set
	 */
	public void setChnlStatCd(String chnlStatCd) {
		this.chnlStatCd = chnlStatCd;
	}
	/**
	 * @return the chnlTypeCd
	 */
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	/**
	 * @param chnlTypeCd the chnlTypeCd to set
	 */
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	/**
	 * @return the chnlTypeSubCd
	 */
	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}
	/**
	 * @param chnlTypeSubCd the chnlTypeSubCd to set
	 */
	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
	}
	/**
	 * @return the chnlLvlNo
	 */
	public String getChnlLvlNo() {
		return chnlLvlNo;
	}
	/**
	 * @param chnlLvlNo the chnlLvlNo to set
	 */
	public void setChnlLvlNo(String chnlLvlNo) {
		this.chnlLvlNo = chnlLvlNo;
	}
	/**
	 * @return the parRid
	 */
	public String getParRid() {
		return parRid;
	}
	/**
	 * @param parRid the parRid to set
	 */
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	/**
	 * @return the ridTerms
	 */
	public String getRidTerms() {
		return ridTerms;
	}
	/**
	 * @param ridTerms the ridTerms to set
	 */
	public void setRidTerms(String ridTerms) {
		this.ridTerms = ridTerms;
	}
	/**
	 * @return the parRidTop
	 */
	public String getParRidTop() {
		return parRidTop;
	}
	/**
	 * @param parRidTop the parRidTop to set
	 */
	public void setParRidTop(String parRidTop) {
		this.parRidTop = parRidTop;
	}
	/**
	 * @return the ridPgm
	 */
	public String getRidPgm() {
		return ridPgm;
	}
	/**
	 * @param ridPgm the ridPgm to set
	 */
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	/**
	 * @return the ridCustPr
	 */
	public String getRidCustPr() {
		return ridCustPr;
	}
	/**
	 * @param ridCustPr the ridCustPr to set
	 */
	public void setRidCustPr(String ridCustPr) {
		this.ridCustPr = ridCustPr;
	}
	/**
	 * @return the acrlPsblYn
	 */
	public String getAcrlPsblYn() {
		return acrlPsblYn;
	}
	/**
	 * @param acrlPsblYn the acrlPsblYn to set
	 */
	public void setAcrlPsblYn(String acrlPsblYn) {
		this.acrlPsblYn = acrlPsblYn;
	}
	/**
	 * @return the usePsblYn
	 */
	public String getUsePsblYn() {
		return usePsblYn;
	}
	/**
	 * @param usePsblYn the usePsblYn to set
	 */
	public void setUsePsblYn(String usePsblYn) {
		this.usePsblYn = usePsblYn;
	}
	/**
	 * @return the mbrJoinPsblYn
	 */
	public String getMbrJoinPsblYn() {
		return mbrJoinPsblYn;
	}
	/**
	 * @param mbrJoinPsblYn the mbrJoinPsblYn to set
	 */
	public void setMbrJoinPsblYn(String mbrJoinPsblYn) {
		this.mbrJoinPsblYn = mbrJoinPsblYn;
	}
	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}
	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}
	/**
	 * @return the modNum
	 */
	public String getModNum() {
		return modNum;
	}
	/**
	 * @param modNum the modNum to set
	 */
	public void setModNum(String modNum) {
		this.modNum = modNum;
	}
	/**
	 * @return the createDate
	 */
	public String getCreateDate() {
		return createDate;
	}
	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	/**
	 * @return the createBy
	 */
	public String getCreateBy() {
		return createBy;
	}
	/**
	 * @param createBy the createBy to set
	 */
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	/**
	 * @return the modifyDate
	 */
	public String getModifyDate() {
		return modifyDate;
	}
	/**
	 * @param modifyDate the modifyDate to set
	 */
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	/**
	 * @return the modifyBy
	 */
	public String getModifyBy() {
		return modifyBy;
	}
	/**
	 * @param modifyBy the modifyBy to set
	 */
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	/**
	 * @return the pgmNm
	 */
	public String getPgmNm() {
		return pgmNm;
	}
	/**
	 * @param pgmNm the pgmNm to set
	 */
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	/**
	 * @return the termsNm
	 */
	public String getTermsNm() {
		return termsNm;
	}
	/**
	 * @param termsNm the termsNm to set
	 */
	public void setTermsNm(String termsNm) {
		this.termsNm = termsNm;
	}

	public String getPntAcrlYn() {
		return pntAcrlYn;
	}

	public void setPntAcrlYn(String pntAcrlYn) {
		this.pntAcrlYn = pntAcrlYn;
	}

	public String getPntRdmYn() {
		return pntRdmYn;
	}

	public void setPntRdmYn(String pntRdmYn) {
		this.pntRdmYn = pntRdmYn;
	}

}
