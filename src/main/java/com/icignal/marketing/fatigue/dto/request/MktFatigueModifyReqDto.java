package com.icignal.marketing.fatigue.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.marketing.fatigue.dto.request
 * @date : 2015. 11. 30.
 * @author : 안형욱
 * @description : 피로도 수정
 */


public class MktFatigueModifyReqDto extends CommonDataAuthReqDto{
	
	private String id;					//아이디
	private String chnlTypeCd;			//채널 유형 코드
	private String periodDiv;			//기간 구분
	private String maxRstrtnTmscnt;		//최대 제한 횟수
	private String startDate;			//시작일자
	private String endDate;				//종료일자
	private String fatigueDesc;			//설명
	private String non_react_day;		//미반응 기간(일)
	private String non_react_cnt;		//미반응 건수
	
	private String accountId;			//회사아이디
	private String maxDayCnt;

	private String fatiState;  //피로도 상태 여부
	private String fatiTitle; //피로도 제목
	private String fatiRestrictionDay; // 피로도 기한(일)
	private String fatiMaxRestrictionDayCnt; //피로도 최대 제한 횟수(일)
	private String fatiDesc; //피로도 설명
	private String chnlCheckedList;

	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getPeriodDiv() {
		return periodDiv;
	}
	public void setPeriodDiv(String periodDiv) {
		this.periodDiv = periodDiv;
	}
	public String getMaxRstrtnTmscnt() {
		return maxRstrtnTmscnt;
	}
	public void setMaxRstrtnTmscnt(String maxRstrtnTmscnt) {
		this.maxRstrtnTmscnt = maxRstrtnTmscnt;
	}
	public String getNon_react_day() {
		return non_react_day;
	}
	public void setNon_react_day(String non_react_day) {
		this.non_react_day = non_react_day;
	}
	public String getNon_react_cnt() {
		return non_react_cnt;
	}
	public void setNon_react_cnt(String non_react_cnt) {
		this.non_react_cnt = non_react_cnt;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getFatigueDesc() {
		return fatigueDesc;
	}
	public void setFatigueDesc(String fatigueDesc) {
		this.fatigueDesc = fatigueDesc;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getMaxDayCnt() {
		return maxDayCnt;
	}
	public void setMaxDayCnt(String maxDayCnt) {
		this.maxDayCnt = maxDayCnt;
	}

	public String getFatiTitle() {
		return fatiTitle;
	}

	public void setFatiTitle(String fatiTitle) {
		this.fatiTitle = fatiTitle;
	}

	public String getFatiRestrictionDay() {
		return fatiRestrictionDay;
	}

	public void setFatiRestrictionDay(String fatiRestrictionDay) {
		this.fatiRestrictionDay = fatiRestrictionDay;
	}

	public String getFatiMaxRestrictionDayCnt() {
		return fatiMaxRestrictionDayCnt;
	}

	public void setFatiMaxRestrictionDayCnt(String fatiMaxRestrictionDayCnt) {
		this.fatiMaxRestrictionDayCnt = fatiMaxRestrictionDayCnt;
	}

	public String getFatiDesc() {
		return fatiDesc;
	}

	public void setFatiDesc(String fatiDesc) {
		this.fatiDesc = fatiDesc;
	}

	public String getFatiState() { return fatiState; }

	public void setFatiState(String fatiState) { this.fatiState = fatiState; }

	public String getChnlCheckedList() {
		return chnlCheckedList;
	}

	public void setChnlCheckedList(String chnlCheckedList) {
		this.chnlCheckedList = chnlCheckedList;
	}
}
