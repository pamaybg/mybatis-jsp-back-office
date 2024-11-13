package com.icignal.marketing.fatigue.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @name : infavor.marketing.personal.dto.response
 * @date : 2015. 11. 30.
 * @author : 안형욱
 * @description : 피로도 목록조회 ResponseDTO
 */
@CommCode
public class MktFatigueDetailResDto extends GridPagingItemResDto {

	private String fatiState; //피로도 상태 여부
	private String fatiStateNm;

	private String id;					//아이디
	private String chnlTypeCd;			//채널 유형 코드
	private String chnlTypeCdName;		//채널 유형명
	private String periodDiv;			//기간 구분
	private String periodDivName;		//기간 구분명
	private String maxRstrtnTmscnt;		//최대 제한 횟수
	private String startDate;			//시작일자
	private String endDate;				//종료일자
	private String fatigueDesc;			//설명
	private String non_react_day;		//미반응 기간(일)
	private String non_react_cnt;		//미반응 건수
	
	
	private String createBy;    		//생성일
	private String createDate;     		//생성자
	private String modifyBy;    		//수정일
	private String modifyDate;     		//수정자
	private String maxDayCnt;


	private String fatiTitle; //피로도 제목

	private String fatiRestrictionDay; // 피로도 기한(일)
	private String fatiMaxRestrictionDayCnt; //피로도 최대 제한 횟수(일)
	private String fatiDesc; //피로도 설명
	private String chnlList;
	private boolean smsFlag = false;
	private boolean lmsFlag = false;
	private boolean mmsFlag = false;
	private boolean pushFlag = false;
	private boolean emailFlag = false;
	private boolean kakaoFrFlag = false;



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
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getChnlTypeCdName() {
		return chnlTypeCdName;
	}
	public void setChnlTypeCdName(String chnlTypeCdName) {
		this.chnlTypeCdName = chnlTypeCdName;
	}
	public String getPeriodDivName() {
		return periodDivName;
	}
	public void setPeriodDivName(String periodDivName) {
		this.periodDivName = periodDivName;
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

	public String getFatiState() {
		return fatiState;
	}

	public void setFatiState(String fatiState) {
		this.fatiState = fatiState;
	}

	public String getFatiStateNm() {
		return fatiStateNm;
	}

	public void setFatiStateNm(String fatiStateNm) {
		this.fatiStateNm = fatiStateNm;
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
	public String getChnlList() {
		return chnlList;
	}

	public void setChnlList(String chnlList) {
		this.chnlList = chnlList;
	}

	public boolean isSmsFlag() {
		return smsFlag;
	}

	public void setSmsFlag(boolean smsFlag) {
		this.smsFlag = smsFlag;
	}

	public boolean isLmsFlag() {
		return lmsFlag;
	}

	public void setLmsFlag(boolean lmsFlag) {
		this.lmsFlag = lmsFlag;
	}

	public boolean isMmsFlag() {
		return mmsFlag;
	}

	public void setMmsFlag(boolean mmsFlag) {
		this.mmsFlag = mmsFlag;
	}

	public boolean isPushFlag() {
		return pushFlag;
	}

	public void setPushFlag(boolean pushFlag) {
		this.pushFlag = pushFlag;
	}

	public boolean isEmailFlag() {
		return emailFlag;
	}

	public void setEmailFlag(boolean emailFlag) {
		this.emailFlag = emailFlag;
	}

	public boolean isKakaoFrFlag() {
		return kakaoFrFlag;
	}

	public void setKakaoFrFlag(boolean kakaoFrFlag) {
		this.kakaoFrFlag = kakaoFrFlag;
	}
}
