package com.icignal.marketing.campaignhome.dto.response;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class CampignBaseResDto extends CommonDataAuthReqDto{

	private String currCnt;  //당월신규고객수
	
	private String currFirstDayCnt;//당일 첫구매 고객
	private String preFirstDayCnt;//전일 첫구매 고객
	private String currFirstMonthCnt;//당월 첫구매 고객
	
	private String preFirstPreMonthCnt;//전월 첫구매 고객
	private Integer firstPluscnt; // 첫구매 고객 증감수
	
	private String  preGrow; //전월대비 증감수 
	private String cuurCntDay; //당일신규고객수
	private String yearMonth;
	private String lastUpdateDate;
	private String lastMonthCnt;	
	private String totProgCnt; //전체 진행
	private String totExtCnt;  // 전체 종료 
	private String monthProgCnt;  //당월 진행
	private String monthExtCnt;   //당월 종료
	private String lastCnt;
	private Integer plusCnt;
	private String basePnt;  //누적 잔액
	private String acrlMonth; //당월 적립
	private String rdmPnt; // 당월 사용
	private String acrlBeforeDay;  // 전일 적립 포인트
	private String usePntBeforeDay;  // 전일 사용 포인트

	private String yyyyMmDd;
	private String createDate;
	private String modifyDate;
	private int actMbrCnt;
	private int actMbrCntPm;
	private int actMbrCntPy;
	private int newMbrCnt;
	private int dorMbrCnt;
	private int secsnMbrCnt;
	private int loginCntD;
	private int loginCntPd;
	private int loginCntM;
	private int loginCntPm;
	private int loginCntY;
	private int loginCntPy;
	private int smsAgrMbrCnt;
	private int pushAgrMbrCnt;
	private int emailAgrMbrCnt;

	private int totCampaignCnt; //캠페인 수
	private int sendSucesCnt; //성공
	private int camTgtCnt; //타겟
	private int purCnt; //구매건수
	private int purRate; //구매율
	private int totSale; //매출액
	private int totSaleRate; //매출액비율
	private int purIncremental; //Incremental 매출액

	public String getCurrFirstDayCnt() {
		return currFirstDayCnt;
	}
	public void setCurrFirstDayCnt(String currFirstDayCnt) {
		this.currFirstDayCnt = currFirstDayCnt;
	}
	public String getPreFirstDayCnt() {
		return preFirstDayCnt;
	}
	public void setPreFirstDayCnt(String preFirstDayCnt) {
		this.preFirstDayCnt = preFirstDayCnt;
	}
	public String getCurrFirstMonthCnt() {
		return currFirstMonthCnt;
	}
	public void setCurrFirstMonthCnt(String currFirstMonthCnt) {
		this.currFirstMonthCnt = currFirstMonthCnt;
	}
	public String getPreFirstPreMonthCnt() {
		return preFirstPreMonthCnt;
	}
	public void setPreFirstPreMonthCnt(String preFirstPreMonthCnt) {
		this.preFirstPreMonthCnt = preFirstPreMonthCnt;
	}

	public String getBasePnt() {
		return basePnt;
	}
	public void setBasePnt(String basePnt) {
		this.basePnt = basePnt;
	}
	public String getAcrlMonth() {
		return acrlMonth;
	}
	public void setAcrlMonth(String acrlMonth) {
		this.acrlMonth = acrlMonth;
	}

	public String getAcrlBeforeDay() {
		return acrlBeforeDay;
	}
	public void setAcrlBeforeDay(String acrlBeforeDay) {
		this.acrlBeforeDay = acrlBeforeDay;
	}
	public String getUsePntBeforeDay() {
		return usePntBeforeDay;
	}
	public void setUsePntBeforeDay(String usePntBeforeDay) {
		this.usePntBeforeDay = usePntBeforeDay;
	}

	public String getCurrCnt() {
		return currCnt;
	}
	public void setCurrCnt(String currCnt) {
		this.currCnt = currCnt;
	}
	public String getPreGrow() {
		return preGrow;
	}
	public void setPreGrow(String preGrow) {
		this.preGrow = preGrow;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public String getLastUpdateDate() {
		return lastUpdateDate;
	}
	public void setLastUpdateDate(String lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}
	public String getLastMonthCnt() {
		return lastMonthCnt;
	}
	public void setLastMonthCnt(String lastMonthCnt) {
		this.lastMonthCnt = lastMonthCnt;
	}

	public String getCuurCntDay() {
		return cuurCntDay;
	}
	public void setCuurCntDay(String cuurCntDay) {
		this.cuurCntDay = cuurCntDay;
	}
	public String getTotProgCnt() {
		return totProgCnt;
	}
	public void setTotProgCnt(String totProgCnt) {
		this.totProgCnt = totProgCnt;
	}
	public String getTotExtCnt() {
		return totExtCnt;
	}
	public void setTotExtCnt(String totExtCnt) {
		this.totExtCnt = totExtCnt;
	}
	public String getMonthProgCnt() {
		return monthProgCnt;
	}
	public void setMonthProgCnt(String monthProgCnt) {
		this.monthProgCnt = monthProgCnt;
	}
	public String getMonthExtCnt() {
		return monthExtCnt;
	}
	public void setMonthExtCnt(String monthExtCnt) {
		this.monthExtCnt = monthExtCnt;
	}
	public String getLastCnt() {
		return lastCnt;
	}
	public void setLastCnt(String lastCnt) {
		this.lastCnt = lastCnt;
	}
	public Integer getPlusCnt() {
		return plusCnt;
	}
	public void setPlusCnt(Integer plusCnt) {
		this.plusCnt = plusCnt;
	}
	public String getRdmPnt() {
		return rdmPnt;
	}
	public void setRdmPnt(String rdmPnt) {
		this.rdmPnt = rdmPnt;
	}
	public Integer getFirstPluscnt() {
		return firstPluscnt;
	}
	public void setFirstPluscnt(Integer firstPluscnt) {
		this.firstPluscnt = firstPluscnt;
	}

	public String getYyyyMmDd() {
		return yyyyMmDd;
	}

	public void setYyyyMmDd(String yyyyMmDd) {
		this.yyyyMmDd = yyyyMmDd;
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

	public int getActMbrCnt() {
		return actMbrCnt;
	}

	public void setActMbrCnt(int actMbrCnt) {
		this.actMbrCnt = actMbrCnt;
	}

	public int getActMbrCntPm() {
		return actMbrCntPm;
	}

	public void setActMbrCntPm(int actMbrCntPm) {
		this.actMbrCntPm = actMbrCntPm;
	}

	public int getActMbrCntPy() {
		return actMbrCntPy;
	}

	public void setActMbrCntPy(int actMbrCntPy) {
		this.actMbrCntPy = actMbrCntPy;
	}

	public int getNewMbrCnt() {
		return newMbrCnt;
	}

	public void setNewMbrCnt(int newMbrCnt) {
		this.newMbrCnt = newMbrCnt;
	}

	public int getDorMbrCnt() {
		return dorMbrCnt;
	}

	public void setDorMbrCnt(int dorMbrCnt) {
		this.dorMbrCnt = dorMbrCnt;
	}

	public int getSecsnMbrCnt() {
		return secsnMbrCnt;
	}

	public void setSecsnMbrCnt(int secsnMbrCnt) {
		this.secsnMbrCnt = secsnMbrCnt;
	}

	public int getLoginCntD() {
		return loginCntD;
	}

	public void setLoginCntD(int loginCntD) {
		this.loginCntD = loginCntD;
	}

	public int getLoginCntPd() {
		return loginCntPd;
	}

	public void setLoginCntPd(int loginCntPd) {
		this.loginCntPd = loginCntPd;
	}

	public int getLoginCntM() {
		return loginCntM;
	}

	public void setLoginCntM(int loginCntM) {
		this.loginCntM = loginCntM;
	}

	public int getLoginCntPm() {
		return loginCntPm;
	}

	public void setLoginCntPm(int loginCntPm) {
		this.loginCntPm = loginCntPm;
	}

	public int getLoginCntY() {
		return loginCntY;
	}

	public void setLoginCntY(int loginCntY) {
		this.loginCntY = loginCntY;
	}

	public int getLoginCntPy() {
		return loginCntPy;
	}

	public void setLoginCntPy(int loginCntPy) {
		this.loginCntPy = loginCntPy;
	}

	public int getSmsAgrMbrCnt() {
		return smsAgrMbrCnt;
	}

	public void setSmsAgrMbrCnt(int smsAgrMbrCnt) {
		this.smsAgrMbrCnt = smsAgrMbrCnt;
	}

	public int getPushAgrMbrCnt() {
		return pushAgrMbrCnt;
	}

	public void setPushAgrMbrCnt(int pushAgrMbrCnt) {
		this.pushAgrMbrCnt = pushAgrMbrCnt;
	}

	public int getEmailAgrMbrCnt() {
		return emailAgrMbrCnt;
	}

	public void setEmailAgrMbrCnt(int emailAgrMbrCnt) {
		this.emailAgrMbrCnt = emailAgrMbrCnt;
	}

	public int getTotCampaignCnt() {
		return totCampaignCnt;
	}

	public void setTotCampaignCnt(int totCampaignCnt) {
		this.totCampaignCnt = totCampaignCnt;
	}

	public int getSendSucesCnt() {
		return sendSucesCnt;
	}

	public void setSendSucesCnt(int sendSucesCnt) {
		this.sendSucesCnt = sendSucesCnt;
	}

	public int getCamTgtCnt() {
		return camTgtCnt;
	}

	public void setCamTgtCnt(int camTgtCnt) {
		this.camTgtCnt = camTgtCnt;
	}

	public int getPurCnt() {
		return purCnt;
	}

	public void setPurCnt(int purCnt) {
		this.purCnt = purCnt;
	}

	public int getPurRate() {
		return purRate;
	}

	public void setPurRate(int purRate) {
		this.purRate = purRate;
	}

	public int getTotSale() {
		return totSale;
	}

	public void setTotSale(int totSale) {
		this.totSale = totSale;
	}

	public int getTotSaleRate() {
		return totSaleRate;
	}

	public void setTotSaleRate(int totSaleRate) {
		this.totSaleRate = totSaleRate;
	}

	public int getPurIncremental() {
		return purIncremental;
	}

	public void setPurIncremental(int purIncremental) {
		this.purIncremental = purIncremental;
	}
}
