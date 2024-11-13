package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyMbrPointAuthResDto extends StatusResDto {
	private String maxPoint;
	private String authCheck;
	
	//포인트 양도 사용량
	private int useDayMax;	//1일사용 최대포인트
	private int usePerMax;	//1회사용 최대포인트
	private int useHudl;		//사용 허들(최소포인트)
	private int useUnit;		//사용단위
	private int usePoint;		//사용한 포인트
	
	private float giftFeeCntAmt;			//1회당 선물 수수료
	private float giftFeeMileageAmt;	//1마일리지당 선물 수수료
	
	private String rst;
	
	public String getAuthCheck() {
		return authCheck;
	}

	public void setAuthCheck(String authCheck) {
		this.authCheck = authCheck;
	}

	public String getMaxPoint() {
		return maxPoint;
	}

	public void setMaxPoint(String maxPoint) {
		this.maxPoint = maxPoint;
	}

	public int getUseDayMax() {
		return useDayMax;
	}

	public void setUseDayMax(int useDayMax) {
		this.useDayMax = useDayMax;
	}

	public int getUsePerMax() {
		return usePerMax;
	}

	public void setUsePerMax(int usePerMax) {
		this.usePerMax = usePerMax;
	}

	public int getUseHudl() {
		return useHudl;
	}

	public void setUseHudl(int useHudl) {
		this.useHudl = useHudl;
	}

	public int getUseUnit() {
		return useUnit;
	}

	public void setUseUnit(int useUnit) {
		this.useUnit = useUnit;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}



	public float getGiftFeeCntAmt() {
		return giftFeeCntAmt;
	}

	public void setGiftFeeCntAmt(float giftFeeCntAmt) {
		this.giftFeeCntAmt = giftFeeCntAmt;
	}

	public float getGiftFeeMileageAmt() {
		return giftFeeMileageAmt;
	}

	public void setGiftFeeMileageAmt(float giftFeeMileageAmt) {
		this.giftFeeMileageAmt = giftFeeMileageAmt;
	}

	public String getRst() {
		return rst;
	}

	public void setRst(String rst) {
		this.rst = rst;
	}
	
}
