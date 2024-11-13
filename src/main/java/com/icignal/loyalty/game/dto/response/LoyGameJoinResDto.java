package com.icignal.loyalty.game.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

@CommCode
public class LoyGameJoinResDto extends GridPagingItemResDto {

	private String rid;
	private String createDate;
	private String createBy;
	private String mbrNo;
	private String joinDate;
	private String ridOfrWin;
	private String ofrNm;
	private String winYn;
	private String ofrWinQty;
	private String ofrWinAvailDay;
	private String ofrWinEarnDate;

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

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getOfrNm() {
		return ofrNm;
	}

	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}

	public String getRidOfrWin() {
		return ridOfrWin;
	}

	public void setRidOfrWin(String ridOfrWin) {
		this.ridOfrWin = ridOfrWin;
	}

	public String getOfrWinQty() {
		return ofrWinQty;
	}

	public void setOfrWinQty(String ofrWinQty) {
		this.ofrWinQty = ofrWinQty;
	}

	public String getOfrWinAvailDay() {
		return ofrWinAvailDay;
	}

	public void setOfrWinAvailDay(String ofrWinAvailDay) {
		this.ofrWinAvailDay = ofrWinAvailDay;
	}

	public String getOfrWinEarnDate() {
		return ofrWinEarnDate;
	}

	public void setOfrWinEarnDate(String ofrWinEarnDate) {
		this.ofrWinEarnDate = ofrWinEarnDate;
	}

	public String getWinYn() {
		return winYn;
	}

	public void setWinYn(String winYn) {
		this.winYn = winYn;
	}
}
