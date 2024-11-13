package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class CouponDtlResDto extends CommonDataAuthReqDto {
	

	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	private String flag;

	private String ridOfr;
	private String issType;
	@MarkName(groupCode = "LOY_CPN_ISS_TYPE", codeField = "issType")
	private String issTypeNm;
	
	private String issDupYn;
	private String issStartDate;
	private String issEndDate;
	private String issMaxCnt;
	private String thumbImgBefUrl;
    private String thumbImgAftUrl;

	private String cpndescText;
	private String useExpirType;
	@MarkName(groupCode = "LOY_CPN_EXPIR_TYPE", codeField = "useExpirType")
	private String useExpirTypeNM;
	
	private String useExpirDayCnt;
	private String useFixStartDate;
	private String useFixEndDate;
	private String useDupYn;
	private String useMinPurAmt;
	private String useMaxDcAmt;
	private String useWeekMon;
	private String useWeekTue;
	private String useWeekWed;
	private String useWeekThu;
	private String useWeekFri;
	private String useWeekSat;
	private String useWeekSun;
	private String usableMaxCnt;
	private String useFixStartTime;
	private String useFixEndTime;
	private String issChnl;
	private String issChnlRid;
	private String offYn;
	
	
	public String getOffYn() {
		return offYn;
	}
	public void setOffYn(String offYn) {
		this.offYn = offYn;
	}
	public String getIssChnl() {
		return issChnl;
	}
	public void setIssChnl(String issChnl) {
		this.issChnl = issChnl;
	}
	public String getIssChnlRid() {
		return issChnlRid;
	}
	public void setIssChnlRid(String issChnlRid) {
		this.issChnlRid = issChnlRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
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
	public String getRidOfr() {
		return ridOfr;
	}
	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}
	public String getIssType() {
		return issType;
	}
	public void setIssType(String issType) {
		this.issType = issType;
	}
	public String getIssDupYn() {
		return issDupYn;
	}
	public void setIssDupYn(String issDupYn) {
		this.issDupYn = issDupYn;
	}
	public String getIssStartDate() {
		return issStartDate;
	}
	public void setIssStartDate(String issStartDate) {
		this.issStartDate = issStartDate;
	}
	public String getIssEndDate() {
		return issEndDate;
	}
	public void setIssEndDate(String issEndDate) {
		this.issEndDate = issEndDate;
	}
	public String getIssMaxCnt() {
		return issMaxCnt;
	}
	public void setIssMaxCnt(String issMaxCnt) {
		this.issMaxCnt = issMaxCnt;
	}
	public String getThumbImgBefUrl() {
		return thumbImgBefUrl;
	}
	public void setThumbImgBefUrl(String thumbImgBefUrl) {
		this.thumbImgBefUrl = thumbImgBefUrl;
	}

	public String getUseExpirType() {
		return useExpirType;
	}
	public void setUseExpirType(String useExpirType) {
		this.useExpirType = useExpirType;
	}
	public String getUseExpirDayCnt() {
		return useExpirDayCnt;
	}
	public void setUseExpirDayCnt(String useExpirDayCnt) {
		this.useExpirDayCnt = useExpirDayCnt;
	}
	public String getUseFixStartDate() {
		return useFixStartDate;
	}
	public void setUseFixStartDate(String useFixStartDate) {
		this.useFixStartDate = useFixStartDate;
	}
	public String getUseFixEndDate() {
		return useFixEndDate;
	}
	public void setUseFixEndDate(String useFixEndDate) {
		this.useFixEndDate = useFixEndDate;
	}
	public String getUseDupYn() {
		return useDupYn;
	}
	public void setUseDupYn(String useDupYn) {
		this.useDupYn = useDupYn;
	}
	public String getUseMinPurAmt() {
		return useMinPurAmt;
	}
	public void setUseMinPurAmt(String useMinPurAmt) {
		this.useMinPurAmt = useMinPurAmt;
	}
	public String getUseMaxDcAmt() {
		return useMaxDcAmt;
	}
	public void setUseMaxDcAmt(String useMaxDcAmt) {
		this.useMaxDcAmt = useMaxDcAmt;
	}
	public String getUseWeekMon() {
		return useWeekMon;
	}
	public void setUseWeekMon(String useWeekMon) {
		this.useWeekMon = useWeekMon;
	}
	public String getUseWeekTue() {
		return useWeekTue;
	}
	public void setUseWeekTue(String useWeekTue) {
		this.useWeekTue = useWeekTue;
	}
	public String getUseWeekWed() {
		return useWeekWed;
	}
	public void setUseWeekWed(String useWeekWed) {
		this.useWeekWed = useWeekWed;
	}
	public String getUseWeekThu() {
		return useWeekThu;
	}
	public void setUseWeekThu(String useWeekThu) {
		this.useWeekThu = useWeekThu;
	}
	public String getUseWeekFri() {
		return useWeekFri;
	}
	public void setUseWeekFri(String useWeekFri) {
		this.useWeekFri = useWeekFri;
	}
	public String getUseWeekSat() {
		return useWeekSat;
	}
	public void setUseWeekSat(String useWeekSat) {
		this.useWeekSat = useWeekSat;
	}
	public String getUseWeekSun() {
		return useWeekSun;
	}
	public void setUseWeekSun(String useWeekSun) {
		this.useWeekSun = useWeekSun;
	}
	public String getThumbImgAftUrl() {
		return thumbImgAftUrl;
	}
	public void setThumbImgAftUrl(String thumbImgAftUrl) {
		this.thumbImgAftUrl = thumbImgAftUrl;
	}
	public String getUseExpirTypeNM() {
		return useExpirTypeNM;
	}
	public void setUseExpirTypeNM(String useExpirTypeNM) {
		this.useExpirTypeNM = useExpirTypeNM;
	}
	public String getIssTypeNm() {
		return issTypeNm;
	}
	public void setIssTypeNm(String issTypeNm) {
		this.issTypeNm = issTypeNm;
	}
	public String getCpndescText() {
		return cpndescText;
	}
	public void setCpndescText(String cpndescText) {
		this.cpndescText = cpndescText;
	}
	public String getUsableMaxCnt() {
		return usableMaxCnt;
	}
	public void setUsableMaxCnt(String usableMaxCnt) {
		this.usableMaxCnt = usableMaxCnt;
	}
	public String getUseFixStartTime() {
		return useFixStartTime;
	}
	public void setUseFixStartTime(String useFixStartTime) {
		this.useFixStartTime = useFixStartTime;
	}
	public String getUseFixEndTime() {
		return useFixEndTime;
	}
	public void setUseFixEndTime(String useFixEndTime) {
		this.useFixEndTime = useFixEndTime;
	}
	
	
	
	
}
