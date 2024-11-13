package com.icignal.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class CouponDtlReqDto extends CommonDataAuthReqDto {

	private String rid;

	private String flag;
	private String ridOfr;
	private String issType;
	private String issDupYn;
	private String issStartDate;
	private String issEndDate;
	private int issMaxCnt;
	private String thumbImgBefUrl;
	private String thumbImgAftUrl;
	private String cpndescText;
	private String useExpirType;
	private int useExpirDayCnt;
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
	private int usableMaxCnt;
	private String useFixStartTime;
	private String useFixEndTime;
	private String issChnlRid;
	private String offYn;

	
	public String getOffYn() {
		return offYn;
	}
	public void setOffYn(String offYn) {
		this.offYn = offYn;
	}
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

	public int getIssMaxCnt() {
		return issMaxCnt;
	}
	public void setIssMaxCnt(int issMaxCnt) {
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

	public int getUseExpirDayCnt() {
		return useExpirDayCnt;
	}
	public void setUseExpirDayCnt(int useExpirDayCnt) {
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
	public String getCpndescText() {
		return cpndescText;
	}
	public void setCpndescText(String cpndescText) {
		this.cpndescText = cpndescText;
	}
	public String getThumbImgAftUrl() {
		return thumbImgAftUrl;
	}
	public void setThumbImgAftUrl(String thumbImgAftUrl) {
		this.thumbImgAftUrl = thumbImgAftUrl;
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
	public int getUsableMaxCnt() {
		return usableMaxCnt;
	}
	public void setUsableMaxCnt(int usableMaxCnt) {
		this.usableMaxCnt = usableMaxCnt;
	}
	
	public String getIssChnlRid() {
		return issChnlRid;
	}
	public void setIssChnlRid(String issChnlRid) {
		this.issChnlRid = issChnlRid;
	}

	public String getUseMinPurAmt() {return useMinPurAmt;}
	public void setUseMinPurAmt(String useMinPurAmt) {this.useMinPurAmt = useMinPurAmt;}
	public String getUseMaxDcAmt() {return useMaxDcAmt;}
	public void setUseMaxDcAmt(String useMaxDcAmt) {this.useMaxDcAmt = useMaxDcAmt;}
}
